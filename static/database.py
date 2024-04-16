import dotenv
import os
import pymysqlpool
import uuid
import re
from passlib.hash import sha256_crypt
from datetime import datetime

dotenv.load_dotenv('.env-dev')

pool = pymysqlpool.ConnectionPool(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT')),
    cursorclass=pymysqlpool.DictCursor)


def selectionner_types_billets():
    connection = pool.get_connection()
    cursor = connection.cursor()
    res = cursor.db_query("SELECT * FROM festiqueb.TypesBillets;")
    connection.close()
    return res


def selectionner_item_panier(tbid, sid):
    connection = pool.get_connection()
    cursor = connection.cursor()
    res = cursor.db_query(
        f'SELECT *, A.nom nom_artiste  FROM festiqueb.TypesBillets TB, festiqueb.Spectacles S '
        f'NATURAL LEFT JOIN festiqueb.Artistes A WHERE S.sid = "{sid}" AND TB.tbid = "{tbid}"')
    connection.close()
    return res[0]


def select_type_billet_par_id(tbid):
    connection = pool.get_connection()
    cursor = connection.cursor()
    res = cursor.db_query(f"SELECT * FROM festiqueb.TypesBillets WHERE tbid='{tbid}'")
    connection.close()
    return res[0]


def selectionner_spectacles(spectacle_ids=None):
    connection = pool.get_connection()
    cursor = connection.cursor()
    requete = """
    SELECT
        S.sid,
        A.nom,
        PH.heureDebut,
        PH.heureFin
    FROM festiqueb.Spectacles S
        NATURAL LEFT JOIN festiqueb.Artistes A
        NATURAL LEFT JOIN festiqueb.PlagesHoraires PH
        WHERE PH.date >= CURRENT_DATE AND PH.heureFin > CURRENT_TIME 
    """
    if spectacle_ids is not None:
        placeholder = ', '.join(['%s'] * len(spectacle_ids))
        requete += """ AND sid IN ({})""".format(placeholder)
        res = cursor.db_query(requete, tuple(spectacle_ids))
    else:
        res = cursor.db_query(requete)
    return res


def commander_billets(items, id_utilisateur):
    connection = pool.get_connection()
    cursor = connection.cursor()
    cursor.db_modify(f"CALL CommanderBillets(%s, %s, @id_commande);", (items, id_utilisateur))
    res = dict(cursor.db_query(f"SELECT @id_commande;")[0]).get('@id_commande')
    connection.commit()
    connection.close()
    return res


def selectionner_commande_par_id(id_commande):
    connection = pool.get_connection()
    cursor = connection.cursor()
    res = cursor.db_query(f'SELECT * FROM festiqueb.Commandes WHERE cid=%s', (id_commande,))[0]
    print(res)
    connection.commit()
    connection.close()
    return res


def verifier_acces(id_billet, id_spectacle):
    connection = pool.get_connection()
    cursor = connection.cursor()
    res = cursor.db_query(f'SELECT * '
                          f'FROM festiqueb.Acces WHERE bid=%s AND sid=%s', (id_billet, id_spectacle))[0]
    if res.get('disponible') == 1:
        cursor.db_modify('UPDATE festiqueb.Acces SET disponible = FALSE WHERE bid=%s AND sid=%s',
                         (id_billet, id_spectacle))
        resultat = True
    else:
        resultat = False
    connection.commit()
    connection.close()
    return resultat


def selectionner_programmation():
    connection = pool.get_connection()
    cursor = connection.cursor()

    # Define the SQL query with parameterized placeholders
    requete = """
    SELECT 
        A.nom,
        A.image,
        PH.date,
        PH.heureDebut,
        PH.heureFin
    FROM festiqueb.Spectacles S
    LEFT JOIN festiqueb.Artistes A ON S.aid = A.aid
    LEFT JOIN festiqueb.PlagesHoraires PH ON S.phid = PH.phid
    ORDER BY PH.date ;
    """
    res = cursor.db_query(requete)
    connection.close()
    return res


def hash_password(password):
    return sha256_crypt.hash(password)


def verify_password(password, actual):
    return sha256_crypt.verify(password, actual)


def insert_user(nom, mot_de_passe, telephone, date_naissance, courriel):

    if not check_user_email(courriel):
        return "courriel invalide"

    if not check_user_date(date_naissance):
        return "date_naissance invalide"

    if not check_user_telephone(telephone):
        return "telephone invalide"

    connection = pool.get_connection()
    cursor = connection.cursor()
    mot_de_passe_hache = hash_password(mot_de_passe)
    uid = uuid.uuid4()

    request = """
    INSERT INTO festiqueb.utilisateurs (uid, nom, mot_de_passe, telephone, date_naissance, courriel)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.db_modify(request, (uid, nom, mot_de_passe_hache, telephone, date_naissance, courriel))
    connection.commit()
    connection.close()
    return "Utilisateur créé"


def get_user(email):
    connection = pool.get_connection()
    cursor = connection.cursor()
    user = cursor.db_query('SELECT * FROM festiqueb.Utilisateurs WHERE courriel = %s', (email,))[0]
    return user


def check_user_password(email, password):
    connection = pool.get_connection()
    try:
        cursor = connection.cursor()
        request = "SELECT uid, nom, telephone, mot_de_passe FROM festiqueb.utilisateurs WHERE courriel = %s"

        result = cursor.db_query(request, (email,))[0]
        if result:
            hashed_password = result['mot_de_passe']
            password_check = sha256_crypt.verify(password, hashed_password)
            print(f"Hashed password from database: {hashed_password}")  # Debugging line
            connection.close()
            return password_check, request
    except Exception as e:
        connection.close()
        print(e)
        return False

def check_user_email(email):
    return re.match(r"[^@]+@[^@]+\.[^@]+", email) is not None

def check_user_telephone(telephone):
    return re.match(r"\d{3}-\d{3}-\d{4}", telephone) is not None

def check_user_date(date_naissance):
    try:
        birth_date = datetime.strptime(date_naissance, '%Y-%m-%d').date()
        return birth_date <= datetime.now().date()
    except ValueError:
        return False

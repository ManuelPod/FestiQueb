import dotenv
import os
import pymysqlpool
import uuid
from passlib.hash import sha256_crypt

dotenv.load_dotenv('.env-dev')

pool = pymysqlpool.ConnectionPool(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT')),
    cursorclass=pymysqlpool.DictCursor,
    max_allowed_packet=100)


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
        f'SELECT * FROM festiqueb.TypesBillets TB JOIN festiqueb.Spectacles S ON S.sid = "{sid}" AND TB.tbid = "{tbid}"')
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

    cursor.execute(requete)

    res = cursor.fetchall()

    connection.close()
    return res


def hash_password(password):
    return sha256_crypt.hash(password)


def verify_password(password, actual):
    return sha256_crypt.verify(password, actual)


def insert_user(nom, mot_de_passe, telephone, date_naissance, courriel):
    connection = pool.get_connection()
    cursor = connection.cursor()
    mot_de_passe_haché = hash_password(mot_de_passe)
    uid = uuid.uuid4()
    print(mot_de_passe_haché)

    request = """
    INSERT INTO festiqueb.utilisateurs (uid, nom, mot_de_passe, telephone, date_naissance, courriel)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.db_modify(request, (uid, nom, mot_de_passe_haché, telephone, date_naissance, courriel))
    connection.commit()
    connection.close()


def check_user_password(email, password):
    try:
        connection = pool.get_connection()
        cursor = connection.cursor()
        request = "SELECT mot_de_passe FROM festiqueb.utilisateurs WHERE courriel = %s"

        cursor.execute(request, (email,))
        connection.commit()
        result = cursor.fetchone()
        connection.close()

        if result:
            hashed_password = result['mot_de_passe']
            print(f"Hashed password from database: {hashed_password}")  # Debugging line
            return sha256_crypt.verify(password, hashed_password)


    except Exception as e:
        print(e)
        return False



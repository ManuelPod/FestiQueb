import dotenv
import os
import pymysqlpool

dotenv.load_dotenv('.env-dev')

connection = pymysqlpool.ConnectionPool(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT')),
    cursorclass=pymysqlpool.DictCursor,
    max_allowed_packet=100)


def selectionner_types_billets():
    cursor = connection.get_connection().cursor()
    cursor.execute(
        "SELECT * FROM festiqueb.TypesBillets;")
    res = cursor.fetchall()
    cursor.close()
    return res


def selectionner_item_panier(tbid, sid):
    cursor = connection.get_connection().cursor()
    try:
        cursor.execute(
            f'SELECT * FROM festiqueb.TypesBillets TB JOIN festiqueb.Spectacles S ON S.sid = "{sid}" AND TB.tbid = "{tbid}"')
    except Exception as e:
        print(e)
    res = cursor.fetchone()
    cursor.close()
    return res


def select_type_billet_par_id(tbid):
    cursor = connection.get_connection().cursor()
    cursor.execute(f"SELECT * FROM festiqueb.TypesBillets WHERE tbid='{tbid}'")
    res = cursor.fetchone()
    cursor.close()
    return res


# def commander_billet():
#     cursor = connection.cursor()
#     cursor.execute(f'INSERT INTO festiqueb.Commandes')

def selectionner_spectacles(spectacle_ids=None):
    cursor = connection.get_connection().cursor()
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
        cursor.execute(requete, tuple(spectacle_ids))
    else:
        cursor.execute(requete)
    res = cursor.fetchall()
    return res


def algorithme_assignation_scenes():
    cursor_horaire_scenes = connection.get_connection().cursor()
    cursor_artistes = connection.get_connection().cursor()
    cursor_assignation_spectacles = connection.get_connection().cursor()
    cursor_horaire_scenes.execute(
        f'SELECT * FROM festiqueb.PlagesHoraires, festiqueb.Lieux ORDER BY capacite, heureDebut DESC;')

    cursor_artistes.execute(f'SELECT aid, popularite FROM festiqueb.Artistes ORDER BY popularite;')

    for x in range(0, cursor_artistes.arraysize):
        insertion = f"""
        INSERT INTO festiqueb.Spectacles {x} VALUE
        ()
        """
        cursor_assignation_spectacles.execute(insertion)

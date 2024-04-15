import dotenv
import os
import pymysqlpool

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

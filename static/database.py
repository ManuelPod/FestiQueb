import pymysql
import dotenv
import os

dotenv.load_dotenv('.env-dev')

connection = pymysql.connect(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT'))
)


def selectionner_types_billets():
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM festiqueb.TypesBillets;')
    res = cursor.fetchall()
    cursor.close()
    return res


def select_type_billet(id):
    cursor = connection.cursor()
    cursor.execute(f"SELECT * FROM festiqueb.TypesBillets WHERE tbid='{id}'")
    res = cursor.fetchall()
    cursor.close()
    return res


# def commander_billet():
#     cursor = connection.cursor()
#     cursor.execute(f'INSERT INTO festiqueb.Commandes')

def selectionner_spectacles():
    cursor = connection.cursor()
    selection = """
    SELECT
        S.sid id_spectacle,
        A.nom nom_artiste,
        PH.heureDebut debut,
        PH.heureFin fin
    FROM festiqueb.Spectacles S
        NATURAL LEFT JOIN festiqueb.Artistes A
        NATURAL JOIN festiqueb.PlagesHoraires PH
        WHERE PH.date >= CURRENT_DATE AND PH.heureFin > CURRENT_TIME;
    """
    cursor.execute(selection)
    res = cursor.fetchall()
    return res


def algorithme_assignation_scenes():
    cursor_horaire_scenes = connection.cursor()
    cursor_artistes = connection.cursor()
    cursor_assignation_spectacles = connection.cursor()
    cursor_horaire_scenes.execute(
        f'SELECT * FROM festiqueb.PlagesHoraires, festiqueb.Lieux ORDER BY capacite, heureDebut DESC;')

    cursor_artistes.execute(f'SELECT aid, popularite FROM festiqueb.Artistes ORDER BY popularite;')

    for x in range(0, cursor_artistes.arraysize):
        insertion = f"""
        INSERT INTO festiqueb.Spectacles {x} VALUE
        ()
        """
        cursor_assignation_spectacles.execute(insertion)

from decimal import *
from dotenv import load_dotenv
import os
import pymysql

load_dotenv('../.env-dev')

connection = pymysql.connect(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT'))
)


def generer_types_billets():
    types_billets = [
        {
            'nom': 'Passe générale',
            'prix_median': 120.99,
            'sans_limite': "true",
        },
        {
            'nom': 'Passe VIP',
            'prix_median': 399.99,
            'sans_limite': "true",
        },
        {
            'nom': 'Entrée quotidienne',
            'prix_median': 45.99,
            'sans_limite': 'false',
        }]
    tranches_ages = {'7-12': 0.1, '13-17': 0.30, '18-64': 1.0, '65+': 0.70}
    getcontext().prec = 2
    cursor = connection.cursor()
    id = 1
    cursor.execute('DELETE FROM festiqueb.TypesBillets WHERE True;')
    for type_billet in types_billets:
        for tranche_age in tranches_ages:
            prix = int(round(tranches_ages.get(tranche_age) * type_billet.get('prix_median'), 2)) + .99
            cursor.execute(
                f'INSERT INTO festiqueb.TypesBillets VALUE '
                f'(DEFAULT,"{type_billet.get("nom")}",{type_billet.get("sans_limite")},{prix},"{tranche_age}");')
            id += 1

    connection.commit()
    print('Types billets générés.')
    cursor.close()


def association_spectacles():
    cursor = connection.cursor()
    cursor.execute('DELETE FROM festiqueb.Spectacles WHERE True;')
    cursor.execute(f'CALL AlgorithmeAssignationSpectacles();')
    connection.commit()
    print('Spectacles générés.')
    cursor.close()


generer_types_billets()
association_spectacles()

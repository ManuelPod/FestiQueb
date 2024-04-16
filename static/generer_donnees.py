from decimal import *

import pymysqlpool
from dotenv import load_dotenv
import os
import pathlib

from passlib.handlers.sha2_crypt import sha256_crypt

load_dotenv('../.env')

pool = pymysqlpool.ConnectionPool(
    host=os.environ.get('BD_HOST'),
    user=os.environ.get('BD_USER'),
    database=os.environ.get('BD_DATABASE'),
    passwd=os.environ.get('BD_PASSWORD'),
    port=int(os.environ.get('BD_PORT')),
    cursorclass=pymysqlpool.DictCursor)


# def initDb():
#     connection = pool.get_connection()
#     cursor = connection.cursor()
#     cursor.db_modify('CREATE DATABASE IF NOT EXISTS festiqueb;')
#     cursor.db_modify('USE festiqueb;')
#
#     cursor.db_modify(f"SOURCE init.sql")
#     connection.commit()


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
    connection = pool.get_connection()
    cursor = connection.cursor()
    id = 1
    cursor.db_modify('DELETE FROM festiqueb.TypesBillets WHERE True;')
    for type_billet in types_billets:
        for tranche_age in tranches_ages:
            prix = int(round(tranches_ages.get(tranche_age) * type_billet.get('prix_median'), 2)) + .99
            cursor.db_modify(
                f'INSERT INTO festiqueb.TypesBillets VALUE '
                f'(DEFAULT,"{type_billet.get("nom")}",{type_billet.get("sans_limite")},{prix},"{tranche_age}");')
            id += 1

    connection.commit()
    print('Types billets générés.')
    connection.close()


def association_spectacles():
    connection = pool.get_connection()
    cursor = connection.cursor()
    cursor.db_modify('DELETE FROM festiqueb.Spectacles WHERE True;')
    cursor.db_modify(f'CALL AlgorithmeAssignationSpectacles();')
    connection.commit()
    print('Spectacles générés.')
    connection.close()


def generer_utilisateurs():
    connection = pool.get_connection()
    cursor = connection.cursor()
    utilisateurs = cursor.db_query(f"SELECT * FROM festiqueb.Utilisateurs")
    for utilisateur in utilisateurs:
        cursor.db_modify(f"UPDATE festiqueb.Utilisateurs SET mot_de_passe = %s WHERE uid = %s",
                         (sha256_crypt.hash(utilisateur['mot_de_passe']), utilisateur['uid']))
    connection.commit()
    connection.close()
    print('Utilisateurs générés')


def generer_admin():
    connection = pool.get_connection()
    cursor = connection.cursor()
    cursor.db_modify(
        f"INSERT INTO festiqueb.Utilisateurs VALUE (DEFAULT,'Admin','{sha256_crypt.hash('123')}',"
        "'123-123-1223','2000-01-01','admin@gmail.com',TRUE)")
    cursor.db_modify(
        f"INSERT INTO festiqueb.Utilisateurs VALUE (DEFAULT,'Client','{sha256_crypt.hash('123')}',"
        "'123-123-1223','2000-01-01','client@gmail.com',FALSE)")
    connection.commit()
    connection.close()
    print('Admins générés.')


generer_types_billets()
association_spectacles()
generer_utilisateurs()
generer_admin()

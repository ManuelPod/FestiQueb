from flask import Flask, request, make_response, render_template, jsonify, request, redirect, url_for, session
from static.database import *

app = Flask(__name__)
app.secret_key = 'super secret key'


@app.route('/')
def welcome_page():  # put application's code here
    return render_template('index.html')


@app.route('/magasin')
def magasin():
    types_billets = list(selectionner_types_billets())
    return render_template('magasin.html', types_billets=types_billets)


@app.route('/magasin/<tbid>')
def details_billets(tbid):
    type_billet = select_type_billet_par_id(tbid)
    spectacles = selectionner_spectacles()
    return render_template('details-billet.html', type_billet=type_billet, spectacles=spectacles)


@app.route('/panier')
def panier():
    return render_template('panier.html')


@app.route('/programmation')
def programmation():
    artistes = selectionner_programmation()
    # Print the number and content of artistes
    print("Number of artists:", len(artistes))
    print("Artists:", artistes)
    return render_template('programmation.html', artistes=artistes)


@app.get('/types-billets')
def req_types_billets():
    return selectionner_types_billets()


@app.route('/confirmation-achat')
def afficher_confirmation_commande():
    id_commande = request.args.get('id_commande')
    commande = selectionner_commande_par_id(id_commande)
    return render_template('confirmation-commande.html', commande=commande)


@app.route('/scanner-billet')
def scanner_billet():
    return render_template('scanner-billet.html', spectacles=selectionner_spectacles())


@app.get('/item-panier')
def req_item_panier():
    tbid = request.args.get('tbid')
    sid = request.args.get('sid')
    if sid:
        res = selectionner_item_panier(tbid, sid)
    else:
        res = select_type_billet_par_id(tbid)
    reponse = {
        "status": 200,
        "body": res
    }
    return jsonify(reponse)


@app.context_processor
def injecter_menu():
    return {'menu': 'menu.html'}


# TODO ajouter route pour créer un compte (4)
# TODO ajouter route pour se connecter

# NOT TODO ajouter route pour valider un billet à l'entrée (2)

# NOT TODO ajouter routes pour faire gestion des spectacles (ajouter description, associer les artistes aux scène(procedure faite))


@app.post('/commander')
def creer_commande():
    # try:
    json_data = request.data.decode('utf-8')
    id_commande = commander_billets(json_data, session['user_id'])
    reponse = {
        "status": 200,
        "body": id_commande
    }
    return jsonify(reponse)


@app.post('/valider-billet')
def valider_billet():
    resultat = verifier_acces(request.form.get('id_billet'), request.form.get('spectacle'))
    reponse = {
        "status": 200,
        "body": resultat
    }
    return jsonify(reponse)


# except Exception as e:
#     print(e)
#     return 'Une erreur s\'est produit veuillez réessayer plus tard.', 400


@app.route('/creation_compte', methods=['GET', 'POST'])
def inscription():
    if request.method == 'POST':
        connection = pool.get_connection()
        nom = request.form['nom']
        mot_de_passe = request.form['mot_de_passe']
        telephone = request.form['telephone']
        date_naissance = request.form['date_naissance']
        courriel = request.form['courriel']

        cursor = connection.cursor()

        insert_user(nom, mot_de_passe, telephone, date_naissance, courriel)

        connection.commit()
        cursor.close()

        return redirect('/')
    if request.method == 'GET':
        return render_template('creation-compte.html')


@app.route('/connexion', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        print(f"Password from form: {password}")  # Debugging line

        try:
            if check_user_password(email, password):
                # Authentication successful
                user = get_user(email)
                print(user)
                session['logged_in'] = True
                session['email'] = email
                session['user_id'] = user['uid']
                session['nom'] = user['nom']
                session['is_admin'] = True if user['est_admin'] == 1 else False
                print(session['is_admin'])
                return redirect('/')
            else:
                # Authentication failed
                return "Email ou mot de passe incorrect"
        except ValueError as e:
            return str(e)

    if request.method == 'GET':
        return render_template('connexion.html')


def verifier_paiement():
    return True


if __name__ == '__main__':
    app.run(port=8000, debug=True)

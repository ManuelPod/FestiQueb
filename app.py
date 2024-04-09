from flask import Flask, request, make_response, render_template, jsonify
from static.database import *

app = Flask(__name__)


@app.route('/')
def welcome_page():  # put application's code here
    return render_template('index.html')


@app.route('/magasin')
def magasin():
    type_billets = list(selectionner_types_billets())
    return render_template('magasin.html', types_billets=type_billets)


@app.route('/magasin/<tbid>')
def details_billets(tbid):
    type_billet = select_type_billet(tbid)
    return render_template('details-billet.html', type_billet=type_billet[0], spectacles=selectionner_spectacles())


@app.route('/programmation')
def programmation():
    # TODO faire page d'affichage pour la programmation du festival
    return render_template('programmation.html')


@app.get('/types-billets')
def req_types_billets():
    return selectionner_types_billets()


@app.context_processor
def injecter_menu():
    return {'menu': 'menu.html'}


# TODO ajouter route pour créer un compte

# TODO ajouter route pour se connecter

# TODO ajouter route pour valider un billet à l'entrée

# TODO ajouter routes pour faire gestion des spectacles (ajouter description, associer les artistes aux scène(procedure faite))

# TODO

@app.post('/commande')
def creer_commande():
    return
    # TODO compléter fonction pour faire un commander. Ajouter commande à BD, créer billet et créer accès billet

    # data = request.json
    # print(request)
    # reponse = make_response()
    #
    # if verifier_paiement():
    #     reponse.status_code = 200
    #     return commander_billet()
    # else:
    #     reponse.status = 400
    #     reponse.message = 'Le paiement est invalide!'
    #     return jsonify(reponse)


def verifier_paiement():
    return True


if __name__ == '__main__':
    app.run(port=8000, debug=True)

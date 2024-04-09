sessionStorage.setItem('items', JSON.stringify([]))

function ajouterAuPanier(typeBilletId) {
    const quantite = parseInt(document.querySelector('#quantite').value)
    const spectacleId = document.querySelector('#spectacle').value

    let panier = JSON.parse(sessionStorage.getItem('items'))
    const indexItemExistant = panier.findIndex(item => item.typeBilletId === typeBilletId && item.spectacleId === spectacleId)
    if (indexItemExistant !== -1) {
        panier[indexItemExistant].quantite += quantite
    } else {
        panier.push({typeBilletId, spectacleId, quantite});
    }
    sessionStorage.setItem('items', JSON.stringify(panier))
}

function acheterBillet() {
    const panier = JSON.parse(sessionStorage.getItem('items'))
    fetch('/commande', {
        body: {
            panier
        },
        method: 'POST'
    }).catch((erreur) => {
        afficherErreurPaiement(erreur.message)
    }).then((reponse) => {
        afficherConfirmationAchat(reponse.body, reponse.body);
    });
}

function afficherConfirmationAchat() {

}

function afficherErreurPaiement() {

}


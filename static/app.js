const domaine = 'http://' + location.host

window.onload = function () {
    initialiserEvenements()
    if (location.href === domaine + '/panier') {
        trouverItemsPanier()
    }
}

function ajouterAuPanier(typeBilletId) {
    const quantite = parseInt(document.querySelector('#quantite').value)
    const spectacleId = document.querySelector('#spectacle').value

    if (!sessionStorage.getItem('items')) {
        sessionStorage.setItem('items', JSON.stringify([]))
    }
    let panier = JSON.parse(sessionStorage.getItem('items'))
    const indexItemExistant = panier.findIndex(item => item.typeBilletId === typeBilletId && item.spectacleId === spectacleId)
    if (indexItemExistant !== -1) {
        panier[indexItemExistant].quantite += quantite
    } else {
        panier.push({typeBilletId, spectacleId, quantite});
    }
    document.dispatchEvent(new CustomEvent('majIconePanier', {detail: panier.length}))
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

function trouverItemsPanier() {
    const items = JSON.parse(sessionStorage.getItem('items'))
    items.forEach(async (item) => {
        await fetch(`/item-panier?${new URLSearchParams({tbid: item.typeBilletId, sid: item.spectacleId})}`, {
            method: 'GET',
            headers: {
                "Content-Type": "application/json"
            }
        }).then((reponse) => {
            return reponse.json()
        }).then(data => {
            data.body.quantite = item.quantite
            afficherItemPanier(data.body)
        })
    })
}

function afficherItemPanier(item) {
    const divPanier = document.querySelector('#liste-items-panier')
    const nouveauItem = document.createElement('div')
    console.log(item)
    nouveauItem.innerHTML = `<div class="item-panier">
                                <p class="item-nom">${item.nom} - ${item.categorie_age}</p>
                                <p>Prix: $${item.prix * item.quantite}</p>
                                <p>Quantité: ${item.quantite}</p>
                            </div>`

    divPanier.appendChild(nouveauItem)
}

function initialiserEvenements() {
    const pastille = document.querySelector('#pastille-panier')
    document.addEventListener('majIconePanier', (event) => {
        console.log(event)
        pastille.innerText = event.detail

    })


    document.dispatchEvent(new CustomEvent('majIconePanier', {detail: JSON.parse(sessionStorage.getItem('items')).length}))

}


function afficherConfirmationAchat() {

}

function afficherErreurPaiement() {

}


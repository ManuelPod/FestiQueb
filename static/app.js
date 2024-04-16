const domaine = 'http://' + location.host

window.onload = () => {
    initialiserEvenements()
    if (location.href === domaine + '/panier') {
        trouverItemsPanier()
    }
}

function ajouterAuPanier(typeBilletId) {
    const quantite = parseInt(document.querySelector('#quantite').value)
    const spectacleId = document.querySelector('#spectacle')?.value

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
    location.href = '/magasin'
}

function acheterBillet() {
    const panier = JSON.parse(sessionStorage.getItem('items'))
    if (!verifierPaiement()) {
        return false;
    }
    fetch('/commander', {
        method: 'POST',
        body: JSON.stringify(panier),
        headers: {
            "content-type": "application/json; charset=utf-8"
        }
    }).catch((erreur) => {
        afficherErreurPaiement(erreur.message)
    }).then((reponse) => {
        return reponse.json()
    }).then(json => {
        sessionStorage.clear()
        afficherConfirmationAchat(json.body)
    })
}

function trouverItemsPanier() {
    const items = JSON.parse(sessionStorage.getItem('items'))
    items.forEach(async (item) => {
        await fetch(`/item-panier?tbid=${item.typeBilletId}&sid=${item.spectacleId ?? ''}`, {
            method: 'GET',
            headers: {
                "Content-Type": "application/json"
            }
        }).then(reponse => {
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
    nouveauItem.innerHTML = `<div class="item-panier">
                                <p class="item-nom">${item.nom} - ${item.categorie_age}  ${item.sid ? " - " + item.nom_artiste : ""}</p>
                                <p>Prix: $${item.prix * item.quantite}</p> <span><button onclick="supprimerDuPanier(event,'${item.tbid}', '${item.sid}')">Supprimer du panier</button></span>
                                <p>Quantité: ${item.quantite}</p>
                            </div>`

    divPanier.appendChild(nouveauItem)
}

function supprimerDuPanier(event, tbid, sid) {
    let panier = JSON.parse(sessionStorage.getItem('items'))
    let index = panier.findIndex(item => item.typeBilletId === tbid && item.spectacleId === sid)
    panier.pop(index)
    sessionStorage.setItem('items', JSON.stringify(panier))
    document.dispatchEvent(new CustomEvent('majIconePanier', {detail: panier.length}))
    event.target.parentElement.parentElement.remove()
}

function verifierPaiement() {
    return true
}

function initialiserEvenements() {
    const pastille = document.querySelector('#pastille-panier')
    document.addEventListener('majIconePanier', (event) => {
        pastille.innerText = event.detail
    })

    document.dispatchEvent(new CustomEvent('majIconePanier', {detail: JSON.parse(sessionStorage.getItem('items')).length}))
}


function afficherConfirmationAchat(commandeId) {
    location.href = `/confirmation-achat?id_commande=${commandeId}`
}

function afficherErreurPaiement() {
    location.href = `/erreur-comande`
}

function validerBillet(event) {
    fetch('/valider-billet', {
        method: 'POST',
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            id_billet: document.querySelector('#id_billet').value,
            id_spectacle: document.querySelector('#id_spectacle').value
        })
    }).then(res => res.json()).then((response) => {
            const validation = document.querySelector('#resultat-validation');
            if (response.body) {
                validation.innerHTML = `<div style="color: limegreen">
                                VALID
                            </div>`
            } else {
                validation.innerHTML = `<div style="color: red">
                                INVALID
                            </div>`
            }
            document.querySelector('#id_billet').value = ''
        }
    )
}



/* =============================================================
   AFFICHAGE DES FICHES

   Ce fichier lit la liste FICHES (définie dans data/fiches.js)
   et fabrique une carte HTML pour chaque élément.

   Vous n'avez normalement pas besoin de modifier ce fichier,
   sauf si vous vous attaquez à un défi (voir defis.md).
   ============================================================= */

// 1. On repère l'endroit de la page où déposer les fiches.
const conteneur = document.querySelector("#liste-fiches");

// 2. S'il n'y a aucune fiche, on affiche un message d'invitation.
if (FICHES.length === 0) {
  conteneur.innerHTML = `
    <p class="vide">
      Aucune fiche pour l'instant.<br>
      Ajoutez la première dans <code>data/fiches.js</code>.
    </p>
  `;
}

// 3. Sinon, on parcourt la liste et on fabrique une carte par fiche.
FICHES.forEach(function (fiche) {
  const carte = document.createElement("article");
  carte.className = "fiche";

  carte.innerHTML = `
    <span class="fiche__categorie">${fiche.categorie}</span>
    <h2 class="fiche__titre">${fiche.titre}</h2>
    <p class="fiche__texte">${fiche.texte}</p>
    <p class="fiche__auteur">${fiche.auteur}</p>
  `;

  conteneur.appendChild(carte);
});

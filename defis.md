# Les défis

Ces trois défis sont **facultatifs**. Ils ne conditionnent aucune note de TP, mais les groupes qui les réalisent seront valorisés lors de la restitution finale.

Faites-les toujours **sur une branche dédiée**, jamais directement sur `main` :

```
git switch -c defi-compteur
```

---

## Défi ★ — Ajouter une fiche de votre invention

Rien à copier ici. Ouvrez `data/fiches.js`, écrivez une fiche qui vous ressemble, et si vous le souhaitez, glissez une image dans `images/`.

Une bonne fiche est **courte**, **utile**, et **vraie**.

---

## Défi ★★ (A) — Le compteur de fiches

Afficher en haut de page le nombre de fiches publiées.

**1.** Dans `index.html`, collez cette ligne juste après la balise `</nav>` :

```html
<p class="compteur" id="compteur"></p>
```

**2.** Dans `js/script.js`, collez ces deux lignes tout à la fin du fichier :

```js
const compteur = document.querySelector("#compteur");
compteur.textContent = FICHES.length + " fiches dans le guide";
```

**3.** Dans `css/style.css`, collez ce bloc tout à la fin :

```css
.compteur {
  font-family: var(--police-mono);
  font-size: 0.72rem;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--couleur-discret);
  margin: 1rem 0 0;
}
```

---

## Défi ★★ (B) — Le filtre par catégorie

Ajouter des boutons qui n'affichent que les fiches d'une catégorie.

**1.** Dans `index.html`, collez ces deux lignes juste avant `<section id="liste-fiches"` :

```html
<div class="filtres" id="filtres"></div>
```

**2.** Dans `js/script.js`, **remplacez tout le contenu du fichier** par celui-ci :

```js
const conteneur = document.querySelector("#liste-fiches");
const zoneFiltres = document.querySelector("#filtres");

// Fabrique une carte HTML pour une fiche donnée.
function creerCarte(fiche) {
  const carte = document.createElement("article");
  carte.className = "fiche";
  carte.innerHTML = `
    <span class="fiche__categorie">${fiche.categorie}</span>
    <h2 class="fiche__titre">${fiche.titre}</h2>
    <p class="fiche__texte">${fiche.texte}</p>
    <p class="fiche__auteur">${fiche.auteur}</p>
  `;
  return carte;
}

// Affiche les fiches d'une catégorie ("Toutes" les affiche toutes).
function afficher(categorie) {
  conteneur.innerHTML = "";

  FICHES.forEach(function (fiche) {
    if (categorie === "Toutes" || fiche.categorie === categorie) {
      conteneur.appendChild(creerCarte(fiche));
    }
  });
}

// Construit la liste des boutons à partir des catégories existantes.
const categories = ["Toutes"];
FICHES.forEach(function (fiche) {
  if (categories.indexOf(fiche.categorie) === -1) {
    categories.push(fiche.categorie);
  }
});

categories.forEach(function (categorie) {
  const bouton = document.createElement("button");
  bouton.className = "filtre";
  bouton.textContent = categorie;

  bouton.addEventListener("click", function () {
    document.querySelectorAll(".filtre").forEach(function (b) {
      b.classList.remove("filtre--actif");
    });
    bouton.classList.add("filtre--actif");
    afficher(categorie);
  });

  zoneFiltres.appendChild(bouton);
});

// Au chargement, on affiche tout et on active le premier bouton.
afficher("Toutes");
document.querySelector(".filtre").classList.add("filtre--actif");
```

**3.** Dans `css/style.css`, collez ce bloc tout à la fin :

```css
.filtres {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin-top: 3rem;
}

.filtre {
  font-family: var(--police-mono);
  font-size: 0.7rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--couleur-texte);
  background: transparent;
  border: 1px solid var(--couleur-ligne);
  border-radius: 2px;
  padding: 0.45rem 0.8rem;
  cursor: pointer;
  transition: background 0.15s, color 0.15s, border-color 0.15s;
}

.filtre:hover {
  border-color: var(--couleur-accent);
  color: var(--couleur-accent);
}

.filtre--actif {
  background: var(--couleur-accent);
  border-color: var(--couleur-accent);
  color: var(--couleur-carte);
}
```

---

## Défi ★★ (C) — Le mode sombre

**1.** Dans `index.html`, collez cette ligne juste après la balise
`</nav>` :

```html
<button class="bascule" id="bascule">Mode sombre</button>
```

**2.** Dans `js/script.js`, collez ces lignes tout à la fin :

```js
const bascule = document.querySelector("#bascule");

bascule.addEventListener("click", function () {
  document.body.classList.toggle("sombre");

  if (document.body.classList.contains("sombre")) {
    bascule.textContent = "Mode clair";
  } else {
    bascule.textContent = "Mode sombre";
  }
});
```

**3.** Dans `css/style.css`, collez ce bloc tout à la fin :

```css
body.sombre {
  --couleur-fond: #23262B;
  --couleur-carte: #2E3238;
  --couleur-texte: #ECEAE4;
  --couleur-discret: #9B978E;
  --couleur-ligne: #3B4047;
}

.bascule {
  font-family: var(--police-mono);
  font-size: 0.7rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--couleur-texte);
  background: transparent;
  border: 1px solid var(--couleur-ligne);
  border-radius: 2px;
  padding: 0.45rem 0.8rem;
  margin-top: 1.2rem;
  cursor: pointer;
}

.bascule:hover {
  border-color: var(--couleur-accent);
  color: var(--couleur-accent);
}
```

Remarquez que ce défi ne change **aucune** couleur une par une : il redéfinit les variables du fichier. C'est exactement pour cela qu'elles existent.

---

## Défi ★★★ — Mettre le site en ligne

Sur GitHub, dans votre dépôt :

1. Onglet **Settings**
2. Menu de gauche, section **Pages**
3. Sous *Build and deployment*, choisissez la source **Deploy from a branch**
4. Branche `main`, dossier `/ (root)`, puis **Save**

Une minute plus tard, votre site est en ligne à l'adresse :

```
https://VOTRECOMPTE.github.io/guide-survie/
```

Ajoutez cette adresse en haut du `README.md`, et dans la section **About** du dépôt (roue crantée à droite de la page d'accueil).

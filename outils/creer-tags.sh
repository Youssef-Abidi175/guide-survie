#!/bin/bash
# =============================================================
#  Fabrique les tags de rattrapage du module Git & GitHub.
#
#  Chaque tag correspond à l'état attendu du projet à la fin
#  d'une séance. Un étudiant dont le dépôt est cassé peut ainsi
#  repartir de l'état correct sans que vous ayez à diagnostiquer
#  son problème :
#
#      git fetch --tags
#      git reset --hard etape-4
#
#  À LANCER UNE SEULE FOIS, avant le début du semestre,
#  depuis la racine du dépôt :
#
#      bash outils/creer-tags.sh
#
#  Le script termine en remettant "main" à son état de départ :
#  les étudiants qui clonent ne voient rien des étapes suivantes.
# =============================================================

set -e

# ---------- Vérifications ----------

if [ ! -d .git ]; then
  echo "Erreur : lancez ce script depuis la racine du dépôt guide-survie."
  exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
  echo "Erreur : des modifications ne sont pas validées."
  echo "Faites d'abord : git add . && git commit -m \"...\""
  exit 1
fi

DEPART=$(git rev-parse HEAD)
TMP=$(mktemp -d)

echo "Point de départ : $DEPART"
echo ""

# ---------- Outil d'insertion après un marqueur ----------

inserer_apres() {   # $1 = fichier cible   $2 = marqueur   $3 = fichier à insérer
  awk -v marq="$2" -v f="$3" '
    { print }
    index($0, marq) { while ((getline ligne < f) > 0) print ligne; close(f) }
  ' "$1" > "$1.tmp" && mv "$1.tmp" "$1"
}

# =============================================================
#  ETAPE-2  —  fin de la séance 2  (T01, T02, T03)
# =============================================================

perl -pi -e 's{<h1 class="entete__titre">Guide de Survie</h1>}{<h1 class="entete__titre">Guide de Survie — Promo 2026</h1>}' index.html

cat > "$TMP/contrib.txt" <<'FIN'
- Amira B. — étudiante
FIN
inserer_apres README.md "AJOUTEZ VOTRE NOM CI-DESSOUS" "$TMP/contrib.txt"

echo "notes.txt" >> .gitignore

git add -A
git commit -q -m "Étape 2 : titre du site, contributeurs, fichier ignoré"
git tag -f etape-2
echo "  etape-2  créé"

# =============================================================
#  ETAPE-4  —  fin de la séance 4  (T04)
# =============================================================

perl -pi -e 's{--couleur-accent: #C41E3A;}{--couleur-accent: #1B5E4F;}' css/style.css

git add -A
git commit -q -m "Étape 4 : nouvelle couleur d'accent"
git tag -f etape-4
echo "  etape-4  créé"

# =============================================================
#  ETAPE-5  —  fin de la séance 5  (T05, T06)
# =============================================================

cat > "$TMP/fiches5.txt" <<'FIN'

  {
    titre: "Les prises électriques de l'amphi",
    categorie: "Vie pratique",
    texte: "Il y en a exactement six, toutes au fond à gauche. Arrivez tôt ou venez chargé.",
    auteur: "Amira"
  },

  {
    titre: "Le raccourci par la cour",
    categorie: "Transport",
    texte: "Il fait gagner quatre minutes entre le bâtiment A et le bâtiment C. Fermé après 18h.",
    auteur: "Youssef"
  },
FIN
inserer_apres data/fiches.js "AJOUTEZ VOS FICHES CI-DESSOUS" "$TMP/fiches5.txt"

git add -A
git commit -q -m "Étape 5 : premières fiches des étudiants"
git tag -f etape-5
echo "  etape-5  créé"

# =============================================================
#  ETAPE-7  —  fin de la séance 7  (T07, T08)
# =============================================================

cat > "$TMP/fiches7.txt" <<'FIN'

  {
    titre: "Réviser à deux, pas à cinq",
    categorie: "Études",
    texte: "Au-delà de trois personnes, une session de révision devient une conversation.",
    auteur: "Sarra"
  },

  {
    titre: "Le café d'en face après 17h",
    categorie: "Bons plans",
    texte: "Moitié prix sur les boissons, et des tables assez grandes pour travailler.",
    auteur: "Mehdi"
  },
FIN
inserer_apres data/fiches.js "AJOUTEZ VOS FICHES CI-DESSOUS" "$TMP/fiches7.txt"

cat > "$TMP/lien.txt" <<'FIN'
      <li><a class="menu__lien" href="https://www.bnt.nat.tn">Bibliothèque nationale</a></li>
FIN
inserer_apres index.html "AJOUTEZ VOTRE LIEN CI-DESSOUS" "$TMP/lien.txt"

git add -A
git commit -q -m "Étape 7 : fiches par branche et lien dans le menu"
git tag -f etape-7
echo "  etape-7  créé"

# =============================================================
#  ETAPE-9  —  fin de la séance 9  (T10, conflit résolu)
# =============================================================

perl -pi -e 's{--couleur-accent: #1B5E4F;}{--couleur-accent: #2C4A7C;}' css/style.css

git add -A
git commit -q -m "Étape 9 : couleur d'accent après résolution du conflit"
git tag -f etape-9
echo "  etape-9  créé"

# ---------- Retour à l'état initial ----------

git reset --hard -q "$DEPART"
rm -rf "$TMP"

echo ""
echo "Terminé. La branche main est revenue à son état de départ."
echo ""
git tag -l "etape-*"
echo ""
echo "Il reste à publier les tags :"
echo "    git push origin main --tags"

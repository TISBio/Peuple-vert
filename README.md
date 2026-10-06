# Le Peuple Vert

**Un jeu collectif à la webcam pour comprendre la photosymbiose du ver de Roscoff.**

Créé par **Corentin Spriet, PhD, HDR**, dans le cadre du festival du CNRS Hauts-de-France
(PLBS — Plateformes Lilloises en Biologie & Santé · UGSF — Unité de Glycobiologie Structurale et Fonctionnelle).

Les élèves forment une colonie de *Symsagittifera roscoffensis*, un petit ver marin qui vit en association
avec une micro-algue verte, *Tetraselmis convolutae*. Pour survivre, la colonie doit exposer ses algues
au soleil, se cacher quand un danger arrive et suivre le rythme des marées. Les élèves jouent avec deux
cartes de couleur, **verte** et **bleue**, que la webcam lit en direct.

- une quinzaine d'élèves, environ 5 minutes par partie ;
- deux niveaux : **Explorateurs (6e)** et **Stratèges (terminale)** ;
- un seul fichier HTML, sans compte ni serveur distant : tout se passe sur l'ordinateur de l'atelier.

## Ce qu'on y découvre

- la **photosymbiose** : le ver naît pâle et doit capturer son algue pour devenir vert ;
- la **photosynthèse** et le cycle **jour / nuit** : pas de lumière, pas d'énergie ;
- la **marée** et le **phototactisme** : le ver remonte vers la lumière à marée basse ;
- l'**équilibre** : trop de lumière stresse aussi les algues (comme le blanchissement des coraux) ;
- des comparaisons avec d'autres stratégies du vivant (plante carnivore, ver de terre) et avec nous.

## Matériel

- un ordinateur avec **webcam** (et idéalement un grand écran ou un vidéoprojecteur) ;
- **deux cartes A4** unies, une verte et une bleue : le PDF `bck/cartes-couleur-test.pdf` (vert `#00B247`,
  bleu `#2255DD`) est à imprimer en couleur ;
- Windows pour le lanceur fourni (sur un autre système, voir « Lancer » ci-dessous).

Le vert et le bleu ont été choisis volontairement : le jaune puis le rouge étaient confondus avec la peau par
la caméra, alors que le bleu est loin des teintes de peau comme du vert.

## Lancer le jeu

La webcam ne fonctionne **pas** si on ouvre le fichier `.html` par double-clic. Le jeu doit être servi par un
petit serveur local (`http://localhost`).

**Sous Windows :** double-cliquez sur `demarrer-le-jeu.bat`. Le lanceur utilise Python s'il est installé,
sinon un petit serveur PowerShell intégré (rien à installer). Laissez la fenêtre noire ouverte pendant toute
la session.

**Autrement :** dans le dossier du projet, lancez `python -m http.server 8000`, puis ouvrez
`http://localhost:8000/peuple-vert-v6.html`.

Les polices sont chargées depuis Google Fonts : sans internet, le jeu fonctionne mais avec des polices de
remplacement.

## Avant la partie : calibration

Sur l'écran d'accueil, **« Réglage salle (matin) »** : cadrez la zone, montrez la carte verte puis la carte
bleue pendant ~1,5 s pour que le jeu apprenne les teintes sous l'éclairage réel. Calibrez à la distance et
dans la lumière de la vraie partie. Le réglage est mémorisé par le navigateur (à refaire sur chaque ordinateur).

La touche **D** affiche un masque de contrôle des pixels reconnus comme verts ou bleus. Le trait au centre de
l'image sépare le **Groupe 1** (gauche) du **Groupe 2** (droite) ; l'image est affichée en miroir.

## Déroulé d'une partie

Réveil de la colonie (échauffement), puis :

1. **Acquisition** : une algue arrive d'un côté, le groupe concerné montre le vert pour l'attirer ;
2. deux tours de **soleil → marée → danger** (ou chasse ciblée d'un prédateur) ;
3. **Blanchiment** : trouver l'équilibre, ni trop ni trop peu de vert ;
4. **Phototaxie** : un groupe au vert (côté éclairé), l'autre au bleu, puis ça s'inverse ;
5. **Plante carnivore** et **ver de terre** : deux autres façons de se nourrir ;
6. **Quiz** « usine à sucres » : vert = vrai, bleu = faux ;
7. **Ovation** : on alterne vert et bleu le plus vite possible, sans bruit ;
8. **Grande marée** finale. La partie va toujours jusqu'au bout : les erreurs font baisser le score final.

## Contenu du dépôt

| Fichier | Rôle |
|---|---|
| `peuple-vert-v6.html` | le jeu (version actuelle) |
| `peuple-vert-v5.stable-backup.html` | version précédente stable, en secours |
| `assets/` | illustrations et photos de laboratoire |
| `demarrer-le-jeu.bat`, `serveur.ps1` | lanceur et serveur local |
| `bck/` | anciennes versions et PDF des cartes |
| `CLAUDE.md` | notes techniques pour reprendre le projet |

## Notes techniques

- HTML / CSS / JavaScript dans un seul fichier, sans dépendance JavaScript externe ;
- détection par la **teinte (HSV)** de chaque pixel dans une zone choisie, avec calibration vert/bleu ;
- bruitages synthétisés (WebAudio), pas de micro ni de fichier audio ;
- les images sont des illustrations générées puis détourées, et des photos de laboratoire.

## Pour aller plus loin (sources scientifiques)

- Bailly et al. (2014), *The chimerical and multifaceted marine acoel Symsagittifera roscoffensis: from photosymbiosis to brain regeneration*, Front. Microbiol. — [10.3389/fmicb.2014.00498](https://doi.org/10.3389/fmicb.2014.00498)
- Arboleda et al. (2018), *An emerging system to study photosymbiosis, brain regeneration, chronobiology, and behavior: the marine acoel Symsagittifera roscoffensis*, BioEssays — [10.1002/bies.201800107](https://doi.org/10.1002/bies.201800107)
- Nissen et al. (2015), *Behaviour of the plathelminth Symsagittifera roscoffensis under different light conditions and the consequences for the symbiotic algae Tetraselmis convolutae*, J. Exp. Biol. — [10.1242/jeb.110429](https://doi.org/10.1242/jeb.110429)
- Carvalho et al. (2013), *Interception of nutrient rich submarine groundwater discharge seepage on European temperate beaches by the acoel flatworm, Symsagittifera roscoffensis*, Mar. Pollut. Bull. — [10.1016/j.marpolbul.2013.07.045](https://doi.org/10.1016/j.marpolbul.2013.07.045)
- Dupont et al. (2012), *Stable photosymbiotic relationship under CO₂-induced acidification in the acoel worm Symsagittifera roscoffensis*, PLoS ONE — [10.1371/journal.pone.0029568](https://doi.org/10.1371/journal.pone.0029568)
- Pennati et al. (2024), *Bisphenol A affects the development and the onset of photosymbiosis in the acoel Symsagittifera roscoffensis*, Mar. Environ. Res. — [10.1016/j.marenvres.2024.106617](https://doi.org/10.1016/j.marenvres.2024.106617)

## Licence

© Corentin Spriet. Ce projet est publié sous licence
**[Creative Commons Attribution - Pas d'Utilisation Commerciale - Partage dans les Mêmes Conditions 4.0 International (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/deed.fr)**
(texte complet dans le fichier `LICENSE`).

En résumé : vous pouvez partager et adapter le jeu, à condition de citer l'auteur, de ne pas en faire un usage
commercial et de redistribuer vos versions sous la même licence.

**Exception :** les logos du PLBS et de l'UGSF (`assets/logo-plbs.jpg`, `assets/logo-ugsf.jpg`) restent la
propriété de leurs titulaires et ne sont pas couverts par cette licence.

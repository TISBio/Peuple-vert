# Le Peuple Vert — jeu collectif à la webcam (Fête de la Science, CNRS Hauts-de-France)

Jeu HTML/CSS/JS **en un seul fichier** sur *Symsagittifera roscoffensis* (le ver de Roscoff) et la photosymbiose.
~15 élèves, ~5 min par partie, 2 profils (« 6e » / « terminale »). Auteur : Corentin Spriet (PhD, HDR).
Répondre en français, de façon concise.

## Fichiers et versions
- `peuple-vert-v6.html` : **version de travail** (miroir caméra, Groupe 1 / Groupe 2, bandeaux d'info en haut, légende XL).
- `peuple-vert-v5.stable-backup.html` : v5 figée, ne pas modifier sauf demande. Anciennes versions dans `bck/`.
- `assets/` : images (illustrations + vraies photos de labo). À garder à côté du `.html`.
- `demarrer-le-jeu.bat` + `serveur.ps1` : lanceur (Python si installé, sinon petit serveur PowerShell). Port 8000.
- `peuple-vert-portable.zip` : paquet à copier sur un autre PC. **À régénérer après toute modif** (copier les fichiers à jour dans `peuple-vert-portable/`, puis re-zipper avec des `/` dans les chemins).
- Dossiers hors dépôt (restent sur le PC principal) : `images vers/`, `Pierre/`, `peuple-vert-portable/`.

## Lancer et tester
- **Jamais en `file://`** : la webcam est bloquée. Toujours `http://localhost` (double-clic sur le `.bat`).
- Quand on teste dans un navigateur, ajouter `?v=<n>` à l'URL (sinon le cache sert l'ancienne version).
- Mode « Simulation » + menu « Aller à la phase… » (`debugJump(kind)`) pour tester une phase. Une fausse webcam se fait avec `canvas.captureStream()`.
- Touche `D` : masque de debug (pixels classés vert/rouge) sur la boîte caméra.

## Détection des couleurs (HSV)
- Cartes : **VERT** `#5BBB6F` (~134°) et **ROUGE** `#E8483A` (~7°). Historique : jaune → rouge → bleu (v6) → de nouveau rouge : sur site, bleu et vert étaient indiscernables en faible lumière. Le rouge est proche de la peau (10–30°) : il a ses propres seuils (`sMinRed()` ≥0.45, `tolRed()` ≈16°, v≥0.16) ; le calibrage rouge ne compte que les pixels saturés (poids s²).
- Les identifiants internes disent encore « yellow » (`cal.yellow`, `--yellow`, `#capYellow`…) : c'est le **ROUGE**. Le texte affiché dit « rouge ».
- `analyze()` : `sMin 0.20`, `tol 35°`, `vMin 0.10` (vert). Séparation Groupe 1 / Groupe 2 au centre de l'image (`CW/2`).
- `MIRROR=true` retourne l'affichage ET le tampon d'analyse (toujours les deux ensemble). Calibration enregistrée dans `localStorage` clé `pv7_cal` (les anciennes clés vert/bleu sont ignorées ; une ROI qui couvre mal un groupe est remise par défaut).
- `camSrc()` choisit la source vidéo selon `state` (`calVideo` seulement pendant la calibration).
- `loop()` est un wrapper `try/catch` autour de `loopBody()` : une erreur ne doit jamais figer le jeu. Le garder.

## Déroulé (`buildPlan`)
acquire → 2 × [sun, maree, danger ou predator] → bleach → phototaxie → carnivore → earthworm → photo (quiz) → cheer (ovation : alterner vert/rouge) → final.
Durées par profil dans l'objet `PROF`.

## Décisions de conception
- Pas de game over : une erreur coûte un cœur et −8 d'énergie, la partie va toujours au bout (score final).
- Pas de son continu ni de micro (ateliers voisins) : uniquement les bruitages ponctuels `sfx()`.
- Les `showChapter()` de carnivore et earthworm sont liés à des timings (`wormFreezeAt`, `trigT`) : si on change leur durée, recalculer toute la chaîne.
- Échauffement : 4 étapes de 5 s max (G1 vert, G1 rouge, G2 vert, G2 rouge), passage automatique quoi qu'il arrive ; l'étape « warm » a aussi des délais (5 s par consigne, 30 s max).
- Danger / prédateur : scène forcée en plein soleil (`tide=0.08`) et pas de long bandeau (effet de surprise).

## Pièges
- Ne jamais arrêter un processus par titre de fenêtre (un filtre trop large a déjà fermé un navigateur ouvert) : seulement par PID exact.
- L'outil `Edit` échoue parfois sur du texte accentué multi-lignes ou des `\uXXXX` : passer par `sed` ou un fichier temporaire.
- Un onglet de navigateur en arrière-plan gèle les transitions CSS (faux négatifs de test) : le mettre au premier plan.
- Dépôt GitHub (privé) : `https://github.com/TISBio/Peuple-vert`, branche `master`. Sur le réseau du labo, `git push`/`clone` peut échouer avec « unable to get local issuer certificate » : utiliser `git -c http.sslBackend=schannel push` (certificats Windows). Ne pas désactiver la vérification SSL.
- Commits : toujours avec l'identité `Corentin Spriet <114572992+TISBio@users.noreply.github.com>` (jamais une adresse e-mail personnelle : le dépôt est public). Passer l'identité par commande (`git -c user.name=... -c user.email=...`) plutôt que de modifier la config git.
- L'historique détaillé des décisions est dans les notes locales du PC principal (non versionnées) ; ce fichier en est le résumé.

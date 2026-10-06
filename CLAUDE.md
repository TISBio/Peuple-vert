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
- Touche `D` : masque de debug (pixels classés vert/bleu) sur la boîte caméra.

## Détection des couleurs (HSV)
- Cartes : **VERT** `#00B247` (~144°) et **BLEU** `#2255DD` (~224°). Jaune puis rouge ont été abandonnés : leurs teintes (0–60°) sont celles de la peau → faux positifs. **Ne pas réintroduire de couleur chaude.**
- Les identifiants internes disent encore « yellow » (`cal.yellow`, `--yellow`, `#capYellow`…) : c'est le **BLEU**. Le texte affiché dit « bleu ».
- `analyze()` : `sMin 0.20`, `tol 35°`, `vMin 0.06`. Séparation Groupe 1 / Groupe 2 au centre de l'image (`CW/2`).
- `MIRROR=true` retourne l'affichage ET le tampon d'analyse (toujours les deux ensemble). Calibration enregistrée dans `localStorage` clé `pv6_cal`.
- `camSrc()` choisit la source vidéo selon `state` (`calVideo` seulement pendant la calibration).
- `loop()` est un wrapper `try/catch` autour de `loopBody()` : une erreur ne doit jamais figer le jeu. Le garder.

## Déroulé (`buildPlan`)
acquire → 2 × [sun, maree, danger ou predator] → bleach → phototaxie → carnivore → earthworm → photo (quiz) → cheer (ovation : alterner vert/bleu) → final.
Durées par profil dans l'objet `PROF`.

## Décisions de conception
- Pas de game over : une erreur coûte un cœur et −8 d'énergie, la partie va toujours au bout (score final).
- Pas de son continu ni de micro (ateliers voisins) : uniquement les bruitages ponctuels `sfx()`.
- Les `showChapter()` de carnivore et earthworm sont liés à des timings (`wormFreezeAt`, `trigT`) : si on change leur durée, recalculer toute la chaîne.
- Danger / prédateur : scène forcée en plein soleil (`tide=0.08`) et pas de long bandeau (effet de surprise).

## Pièges
- Ne jamais arrêter un processus par titre de fenêtre (cela a déjà fermé le Chrome de l'utilisateur) : seulement par PID exact.
- L'outil `Edit` échoue parfois sur du texte accentué multi-lignes ou des `\uXXXX` : passer par `sed` ou un fichier temporaire.
- Un onglet de navigateur en arrière-plan gèle les transitions CSS (faux négatifs de test) : le mettre au premier plan.
- Dépôt GitHub (privé) : `https://github.com/TISBio/Peuple-vert`, branche `master`. Sur le réseau du labo, `git push`/`clone` peut échouer avec « unable to get local issuer certificate » : utiliser `git -c http.sslBackend=schannel push` (certificats Windows). Ne pas désactiver la vérification SSL.
- Historique détaillé des décisions (PC principal uniquement) : `C:\Users\Corentin\.claude\projects\D--AAA-fete-de-la-sciences-FDS2026-CNRS\memory\project_peuple_vert.md`.

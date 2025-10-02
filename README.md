# TD Godot – Jeu complet

Dans ce TD, vous allez compléter le projet de base pour obtenir un petit jeu jouable.
Quatre grands objectifs : **ajouter des ennemis**, **implémenter une attaque**, **ajouter de l’UI**, et **adapter le jeu au mobile**.

---

## 1. Ajout d’ennemis

### 1.1 Créer une scène Enemy

* Créez une nouvelle scène **Enemy**.
* Ajoutez un **Cube rouge** avec une collision.
* Sauvegardez cette scène.

### 1.2 Script Enemy.gd

* Attachez un script `Enemy.gd`.
* Le cube doit **se déplacer vers le joueur** en permanence.

### 1.3 Collisions Enemy ↔ Player

* Si un Enemy touche le Player → le joueur perd 1 PV.
* Mettez à jour la barre de vie.

### 1.4 Reload si Game Over

* Quand la vie du joueur atteint 0 → rechargez la scène.

✅ **Checkpoint :** Vous devez voir apparaître un cube rouge qui poursuit le joueur.

* Si le cube touche le joueur, la vie diminue.
* À 0 PV, la partie recommence.

---

## 2. Ajouter une attaque

### 2.1 Spawn d’un VFX

* À chaque clic de souris (ou tap écran), un **VFX** apparaît à la position du clic sur le sol.

### 2.2 Détruire les ennemis avec le VFX

* Si un ennemi entre dans le VFX → il est détruit.
* Incrémentez un compteur d’ennemis tués.

✅ **Checkpoint :** Quand vous cliquez, un effet apparaît au sol.

* Si un ennemi touche cet effet, il disparaît.
* Le compteur d’ennemis tués s’incrémente correctement.

---

## 3. UI

### 3.1 Compteur d’ennemis tués

* Ajoutez un **Label** affichant le nombre d’ennemis éliminés.
* Mettez-le à jour à chaque destruction.

### 3.2 Écran Game Over

* Ajoutez une **interface Game Over** :

  * Un bouton *Restart* (relance la scène).
  * Un bouton *Quit* (ferme le jeu).

### 3.3 Menu d’accueil

* Créez une scène `MainMenu`.
* Boutons : *Play* (charge la scène principale), *Quit*.
* Le jeu démarre désormais sur ce menu.

✅ **Checkpoint :**

* Le score s’affiche et augmente correctement.
* En cas de Game Over, un écran apparaît avec les bons boutons.
* Le jeu démarre depuis un menu d’accueil.

---

## 4. Adaptation mobile

### 4.1 Déplacement via joystick

* Ajoutez un **joystick UI**.
* Reliez-le au script du Player pour remplacer les touches clavier.

### 4.2 Tap = clic

* Vérifiez qu’un **tap** sur l’écran déclenche bien une attaque comme un clic.

### 4.3 Export APK

* Configurez l’export Android.
* Générez une APK et testez-la sur un smartphone.

✅ **Checkpoint :**

* Sur mobile, le joystick déplace correctement le joueur.
* Un tap sur l’écran fait apparaître le VFX et permet de tuer les ennemis.
* Le jeu est jouable sur un smartphone via une APK.

---

## Bonus possibles

* Ajouter une animation au VFX (grossir puis disparaître).
* Sons (apparition ennemi, destruction, clic).
* Faire apparaître les ennemis de plus en plus vite.

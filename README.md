# TD Godot – Jeu complet

Dans ce TD, vous allez compléter le projet de base pour obtenir un petit jeu jouable.
Quatre grands objectifs : **ajouter des ennemis**, **implémenter une attaque**, **ajouter de l’UI**, et **adapter le jeu au mobile**.

---

## 1. Ajout d’ennemis

### 1.1 Créer une scène Enemy

* Créez une nouvelle scène **Enemy**.
* Pensez à la mettre de type CharacterBody3D pour pouvoir gérer les collisions correctement.
* Ajoutez un **Cube rouge** avec une collision.
* Sauvegardez cette scène.

### 1.2 Script Enemy.gd

* Attachez un script `Enemy.gd`.
* Le cube doit **se déplacer vers le joueur** en permanence.

*Hint: Pour calculer une direction d'un point **A** à un point **B**, on peut faire **B-A**. Le vecteur résultat est le vecteur entre A et B.
Si l'on souhaite juste avoir la direction, il suffit de le normaliser.
Moyen mnémotechnique: "Là où je vais - la où je suis"*

```gdscript
var begin_position: Vector3
var end_position: Vector3

var direction:Vector3

direction = end_position - begin_position
direction = direction.normalized()
```

### 1.3 Collisions Enemy ↔ Player

* Si un Enemy touche le Player → le joueur perd 1 PV.
* Mettez à jour la barre de vie.

* Vous pouvez gérer la collision à l'intérieur du player, ou à l'intérieur de chaque enemy.

*Hint: Vous pouvez utiliser les groupes pour plus de facilité. Assignez le player au groupe "player", et les enemis au groupe "enemies".
Vous pouvez vérifier a quel groupe appartient l'object avec lequel vous venez d'entrer en collision.*

```gdscript
var player = get_tree().get_first_node_in_group("player")

func _on_body_entered(body):
	if body.is_in_group("player"):
		queue_free() #permet de destroy un node, en l'occurence le node actuel
 elif body is Player: #Vous pouvez également regarder le nom de la classe
  #traitement
```

### 1.4 Spawner d'Enemy

Pour avoir un nombre d'enemis infini sur notre jeu, nous avons besoin d'un objet qui gère le spawn de chaque enemy.

* Créer une nouvelle scène **EnemySpawner**.
* Lui attacher un script `EnemySpawner.gd`.
* Au sein de ce script, vous devez faire apparaitre des enemy à intervalle de temps régulier.
* Faites attention à ce que ces ennemis aient une distance acceptable par rapport au player (qu'ils ne spawnent pas sur lui).
* Vous pouvez utiliser les ![timer](https://docs.godotengine.org/en/stable/classes/class_timer.html) de Godot (en créeant un node enfant dans votre scène)
* Ou alors vous pouvez utiliser la fonction `_process(delta)` qui vous permettra de calculer l'intervalle de temps pour spawner votre enemy.

```gdscript
#permet de référencer votre scène enemy au sein de votre script
@export var enemy_scene: PackedScene  

func _on_timer_timeout():
	# Spawner votre enemy
 var enemy = enemy_scene.instantiate()
```

### 1.4 Reload si Game Over

* Quand la vie du joueur atteint 0 → rechargez la scène.
* Si le cube touche le joueur, la vie diminue.
* À 0 PV, la partie recommence.

```gdscript
#permet de reload la scène en cours
get_tree().reload_current_scene()
```

---

## 2. Ajouter une attaque

### 2.1 Spawn d’un VFX

* À chaque clic de souris (ou tap écran), un **VFX** apparaît à la position du clic sur le sol.
* Vous pouvez utiliser la scène `vfx_impact` présente dans le projet.
* Vous pouvez vous placer directement dans le script `Player.gd`, ou alors faire une scène à part avec son propre script, qui gère l'apparition d'un FX.
* Vous devrez probablement utiliser un **raycast**, partant de la caméra et allant jusqu'au sol (ou un enemy) pour savoir ou spawner votre FX.

```gdscript
	# Récupère la caméra dans la scène
	var camera = get_tree().get_first_node_in_group("camera")

	# Permet de récupérer la position de la souris a l'écran (ou du tap en mobile)
	var screen_pos = get_viewport().get_mouse_position()

	# Permet de convertir la position 2D en position de départ 3D & d'arrivée 3D
	var from = camera.project_ray_origin(screen_pos)
	var to = from + camera.project_ray_normal(screen_pos) * 1000.0

	# Permet de récupérer l'espace du world actuel pour créer un raycast
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(from, to)

	# La fonction qui permet vraiment de savoir avec quoi on collisionne
	var result = space_state.intersect_ray(query)

	if result:
		print(result.position)
```

### 2.2 Détruire les ennemis avec le VFX

* Si un ennemi entre dans le VFX → il est détruit.
* Incrémentez un compteur d’ennemis tués.

*Hint: Le type de la scène `vfx_impact.tscn` est `Area3D`. Ce type permet d'implémenter des signaux lorsqu'un objet rentre dans l'aire en question.*

```gdscript
func _on_body_entered(body):
		
```

---

## 3. UI

### 3.1 Compteur d’ennemis tués

* Ajoutez un **Label** affichant le nombre d’ennemis éliminés.
* Mettez-le à jour à chaque destruction.

*Hint: Il est possible d'ajouter un script "global", qui sera load au démarage d'une scène, et accessible depuis n'importe où juste via son nom.
Pour celà, allez dans Project Settings -> Global -> Autoload
Ajoutez votre script ici. 
Pensez à nommer votre script via `class_name VotreNomDeScript` en première ligne de votre script.
On pourrait imaginer un `GameManager.gd` qui regroupe les informations telles que le scores, accessible depuis n'importe ou.*

### 3.2 Écran Game Over

* Ajoutez une **interface Game Over** :

  * Un bouton *Restart* (relance la scène).
  * Un bouton *Quit* (ferme le jeu).

### 3.3 Menu d’accueil

* Créez une scène `MainMenu`.
* Boutons : *Play* (charge la scène principale), *Quit*.
* Le jeu démarre désormais sur ce menu.

---

## 4. Adaptation mobile

### 4.1 Déplacement via joystick

* Ajoutez un **joystick UI**.
* Vous pouvez regarder dans l'AssetLib, un joystick déjà fait par la communauté.
* Faites en sorte que ce joystick bouge le player également.

### 4.2 Tap = clic

* Vérifiez qu’un **tap** sur l’écran déclenche bien une attaque comme un clic.

### 4.3 Export APK

* Configurez l’export Android.
* Générez une APK et testez-la sur un smartphone.

---

## Bonus possibles

* Ajouter une animation au VFX (grossir puis disparaître).
* Sons (apparition ennemi, destruction, clic).
* Faire apparaître les ennemis de plus en plus vite

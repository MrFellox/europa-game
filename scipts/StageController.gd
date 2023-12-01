extends Node

var stage = 0
var wave = 1
var min_enemies = 4
var enemies

# Called when the node enters the scene tree for the first time.

var bat = preload("res://scenes/characters/Bat.tscn")
var stoneGolem = preload("res://scenes/characters/StoneGolem.tscn")

var currentEnemies = 0

func _ready():
	#gen_new_stage()
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Verificar cantidad de enemigos
	
	currentEnemies = 0
	for n in get_parent().get_child_count():
		var currentNode = get_parent().get_child(n)
		#print("\t" + acurrentNode.name)
		
		if (not is_instance_of(currentNode, CharacterBody2D)):
			continue
		
		if currentNode.name == "Player":
			continue
		
		currentEnemies+=1
	
	
	if (currentEnemies == 0):
		#gen_new_stage()
		print("Generando nueva stage...")
		
		wave +=1
		if (wave > 3):
			stage += 1
		
		
		var upperEnemies = min_enemies * randi_range(stage, stage * 2) - stage * 0.25
		enemies = randi_range(min_enemies, upperEnemies);
		
		spawn_enemies(enemies)

func spawn_enemies(enemies: int):
	var player_pos = get_parent().get_child(0).global_position
	
	print("Enemies to generate: " + str(enemies))
	var enemiesLeft = enemies
	
	var newStoneGolems = randi_range(enemies * 0.16, enemies * 0.25)
	enemiesLeft -= newStoneGolems
	var newBats = enemiesLeft
	
	print("Generating " + str(newStoneGolems) + " golems")
	
	for i in range(newStoneGolems):
		var g = stoneGolem.instantiate()
		g.global_position = generate_rand_pos(player_pos)
		currentEnemies += 1
		get_parent().add_child(g)
		
	print("Generating: " + str(newBats) + " bats")
	for i in range(newBats):
		var b = bat.instantiate()
		b.global_position = generate_rand_pos(player_pos)
		currentEnemies += 1
		get_parent().add_child(b)
		print("added")

func generate_rand_pos(player_pos) -> Vector2:
	var distance_from_player = randi_range(100, 200)
	
	var value_modificator = 0
	# Generar un numero aleatorio que no sea cero
	while (value_modificator == 0):
		value_modificator = randi_range(-1, 1)
	
	print("Val mod:" + str(value_modificator))
	var enemy_x_pos = (player_pos.x * value_modificator) + distance_from_player
	print("Player: " + str(player_pos))
	print(enemy_x_pos)
	
	if (player_pos.x <= 3):
		print("too far left")
		enemy_x_pos = player_pos.x - 20
	elif (player_pos.x >= 1250):
		print("to far right")
		enemy_x_pos = player_pos.x + 20
		
	return Vector2(player_pos.x + enemy_x_pos, player_pos.y)

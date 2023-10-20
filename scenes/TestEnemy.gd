extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
var player
var SPEED = 2.5
var gravity
func _ready():
	gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	player = get_parent().get_node("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_pos = player.global_position
	var velocity = global_position.direction_to(player_pos)

	if not is_on_floor():
		pass
		#velocity.y += gravity * delta
	
	move_and_collide(velocity * SPEED)
	
	
	

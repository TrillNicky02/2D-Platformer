#extends Node

#@onready var SM = get_parent()
#@onready var player = get_node("../..")

#func _ready():
#	await player.ready

#func start():
#	player.set_animation("Falling")

#func physics_process(_delta):
	#player.velocity.y += player.gravity * _delta
	
#	player.velocity += player.move_speed * player.move_vector() + player.gravity
	
#	var direction = Input.get_axis("left", "right")
#	if direction: 
		#player.velocity.x = player.direction * player.SPEED
#		player.velocity.x = player.direction * player.move_speed
		
#	else: 
		#player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
#		player.velocity.x = move_toward(player.velocity.x, 0, player.move_speed)

#	player.set_direction(direction)
#	player.move_and_slide()

#	if player.is_on_floor():
#		player.velocity.y = 0
#		SM.set_state("Idle")
#	if player.is_on_ceiling():
#		player.velocity.y = 0
		
		
		
		
		
		
		
extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")

func _ready():
	await player.ready

func start():
	player.set_animation("Falling", Vector2(0,3))
	player.jump_power = Vector2.ZERO

func physics_process(_delta):
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = 0
		if player.is_moving():
			SM.set_state("Moving")
		else:
			SM.set_state("Idle")
		return
	if player.is_on_ceiling():
		player.velocity.y = 0
	if Input.is_action_pressed("jump") and not player.double_jumped and SM.previous_state.name != "WallJump":
		player.double_jumped = true
		SM.set_state("Jumping")
		
	player.velocity += player.move_speed * player.move_vector() + player.gravity
	player.move_and_slide()



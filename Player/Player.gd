#extends CharacterBody2D

#@onready var SM = $StateMachine


#const SPEED = 300.0
#const JUMP_VELOCITY = -50.0
#const MAX_JUMP = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#var direction = 1

#func _ready():
#	up_direction = Vector2.UP

#func _physics_process(_delta):
#	if direction < 0 and not $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = true
#	if direction > 0 and $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = false
	
#func set_direction(d):
#	direction = d

#func set_animation(anim):
#	if $AnimatedSprite2D.animation == anim: return
#	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
#	else: $AnimatedSprite2D.play()
	
	
#func die():
#	queue_free()
	


#func _on_AnimatedSprite_animation_finished():
#	if $AnimatedSprite2D.animation == "Attacking":
#		SM.set_state("Idle")




extends CharacterBody2D

@onready var SM = $StateMachine

var jump_power = Vector2.ZERO
var direction = 1

@export var gravity = Vector2(0,30)

@export var move_speed = 10
@export var max_move = 500

@export var jump_speed = 100
@export var max_jump = 1000


@export var leap_speed = 50
@export var max_leap = 200

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite2D.flip_h: 
			$AnimatedSprite2D.flip_h = true
			$Attack.target_position.x = -1*abs($Attack.target_position.x)
		if direction > 0 and $AnimatedSprite2D.flip_h: 
			$AnimatedSprite2D.flip_h = false
			$Attack.target_position.x = abs($Attack.target_position.x)
	
	if is_on_floor():
		double_jumped = false
		if Input.is_action_just_pressed("attack"):
			SM.set_state("Attacking")

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim, off=Vector2.ZERO):
	if $AnimatedSprite2D.animation == anim: return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()
	$AnimatedSprite2D.offset = off

func attack():
	if $Attack.is_colliding():
		var target = $Attack.get_collider()
		print(target)
		if target.has_method("damage"):
			target.damage()
			
		if target.has_method("die"):
			target.die()	
			
	if $Attack_low.is_colliding():
		var target = $Attack_low.get_collider()
		print(target)
		if target.has_method("damage"):
			target.damage()
			
		if target.has_method("die"):
			target.die()

func die():
	var death_sound = get_node_or_null("/root/Game/PlayerDeath_sound")
	if death_sound != null:
		death_sound.play()
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite2D.animation == "Attacking":
		SM.set_state("Idle")



func _on_coin_collector_body_entered(body):
	if body.name == "Coins":
		body.get_coin(global_position)

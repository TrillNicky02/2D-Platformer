extends CharacterBody2D

@onready var SM = $StateMachine

#@export var walking = 500

@export var walking = 50

@export var running = 1000



#@export var path = [Vector2(4100,1120), Vector2(5250,1120)]

#@export var path = [Vector2(1500,500), Vector2(3200,500)]

@export var path = [Vector2(300,575), Vector2(3200,575)]

var direction = 1

func _ready():
	position = path[0]
	
	#print(position)
	
	velocity.x = walking
	SM.set_state("Move")
	
	#print(position)

func _physics_process(_delta):
	move_and_slide()
	
	#print(position)
	
	if position.x < 320: direction = 1
	if position.x > 3000: direction = -1
	
	#print("direction  ", direction)
	
	
	if velocity.x < 0 and not $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = true
		direction = -1
		$Attack.target_position.x = -1*abs($Attack.target_position.x)
	if velocity.x > 0 and $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = false
		direction = 1
		$Attack.target_position.x = abs($Attack.target_position.x)
	if $AnimatedSprite2D.animation == "Attack": $AnimatedSprite2D.offset.x = 7*direction
	else: $AnimatedSprite2D.offset.x = 0
	
	#print(position)
	
func set_animation(anim):
	if $AnimatedSprite2D.animation == anim and $AnimatedSprite2D.is_playing(): return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack.is_colliding() and $Attack.get_collider().name == "Player":
		return true
	return false

func attack_target():
	
	
	
	if $Attack.is_colliding():
		
		return $Attack.get_collider()
		
	return null

func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()
		
func _on_attack_body_entered(body):
	if body.name == "Player":
		body.die()
		queue_free()

func die():
	var death_sound = get_node_or_null("/root/Game/OrcDeath_sound")
	if death_sound != null:
		death_sound.play()
	queue_free()

func _on_Above_and_Below_body_entered(body):
	if body.name == "Player" :
		body.die()
		if SM.state_name != "Attack":
			queue_free()

	

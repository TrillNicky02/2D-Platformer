extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	var velovelo = enemy.velocity
	
	enemy.set_animation("Attacking")
	
	enemy.velocity = Vector2.ZERO
	
	enemy.velocity = 0.3*velovelo
	
	$Timer.start()
	enemy.velocity = velovelo

func physics_process(_delta):
	pass


func _on_Timer_timeout():
	
	if SM.state_name == "Attack":
		var target = enemy.attack_target()
		
		
		if target != null and target.name == "Player":
			
			
			target.die()
			
			target.queue_free()
			
			
			
			
	SM.state_name == "Move"
	enemy.set_animation("Moving")
	enemy.velocity.x = enemy.direction * enemy.walking
	if enemy.position.x > enemy.path[1].x:
		enemy.velocity.x = -1*abs(enemy.walking)
	if enemy.position.x < enemy.path[0].x:
		enemy.velocity.x = abs(enemy.velocity.x)
	




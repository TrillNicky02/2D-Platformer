extends Area2D

var exit_attempt = 0.0
var exit_chance = 0.5



func _on_Exit_body_entered(body):
	
	if body.name == "Player":
		if name == "Exit_to_2":
			
				
			exit_attempt = randf()
			if exit_chance >= exit_attempt:
				go_next_level()
				Global.score += 1000
			else:
				hit()
				
		elif name == "Exit_to_3":
			exit_attempt = randf()
			if exit_chance >= exit_attempt:
				var _target = get_tree().change_scene_to_file("res://UI/Winner_End_Menu.tscn")
				Global.score += 2000
				
			else:
				hit()


func hit():
	var enemy_sound = get_node_or_null("/root/Game/Exit_sound")
	if enemy_sound != null:
		enemy_sound.play()
	$Confetti.emitting = true
	

func go_next_level():
	var _target = get_tree().change_scene_to_file("res://Levels/Level2.tscn")
	




func _on_pre_exit_area_entered(area):
	$Confetti.emitting = true

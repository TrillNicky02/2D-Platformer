extends Control

func _ready():
	$Label.text = "Thanks For Playing! \nYour Final Score Was " + str(Global.score) + "."


func _on_play_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")


func _on_quit_pressed():
	get_tree().quit()

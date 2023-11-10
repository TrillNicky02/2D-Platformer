extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	var _target = get_tree().change_scene_to_file("res://UI/End_Game.tscn")

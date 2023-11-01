extends Node2D

@onready var Orc = load("res://Enemies/Orc.tscn")
var Orc_starting_position = Vector2(300,575)

@onready var Lizard = load("res://Enemies/Lizard.tscn")
var Lizard_starting_position = Vector2(300,575)

func _ready():
	pass


func _physics_process(_delta):
	if not has_node("Orc"):
		var orc = Orc.instantiate()
		orc.position = Orc_starting_position
		add_child(orc)

	if not has_node("Lizard"):
		var lizard = Lizard.instantiate()
		lizard.position = Lizard_starting_position
		add_child(lizard)


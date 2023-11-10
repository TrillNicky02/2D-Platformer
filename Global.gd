extends Node


var fade = null
var fade_speed = 0.015

var fade_in = false
var fade_out = ""

var death_zone = 1000

var VP = Vector2.ZERO
var score = 200
var lives = 0
var time = 200

var coins = 0



func reset():
	get_tree().paused = false
	score = 200
	time = 200
	lives = 5


func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()




func _physics_process(_delta):
	if fade == null:
		fade = get_node_or_null("/root/Game/Camera3D/Fade")
	if fade_out != "":
		execute_fade_out(fade_out)
	if fade_in:
		execute_fade_in()
		

func start_fade_in():
	if fade != null:
		fade.visible = true
		fade.color.a = 1
		fade_in = true

func start_fade_out(target):
	if fade != null:
		fade.color.a = 0
		fade.visible = true
		fade_out = target

func execute_fade_in():
	if fade != null:
		fade.color.a -= fade_speed
		if fade.color.a <= 0:
			fade_in = false

func execute_fade_out(_target):
	if fade != null:
		fade.color.a += fade_speed
		if fade.color.a >= 1:
			fade_out = ""
			


func add_coin():
	coins += 1
	
	
func update_score(s):
	score += s
	var hud = get_node_or_null("/root/Game/UI/HUD")
	if hud != null:
		hud.update_score()
	
func update_time(t):
	time += t
	update_score(t)
	

	
	
	




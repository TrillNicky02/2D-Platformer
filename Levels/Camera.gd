extends Camera2D


######
# Originally developed by Squirrel Eiserloh (https://youtu.be/tu-Qe66AvtY)
# Refined by KidsCanCode (https://kidscancode.org/godot_recipes/2d/screen_shake/)

var decay = 5							# How quickly the shaking stops
var max_offset = Vector2(15, 0)			# Maximum hor/ver shake in pixels.
var max_roll = 0.05						# Maximum rotation in radians (use sparingly).

var trauma = 0.0						# Current shake strength.
var trauma_power = 3					# Trauma exponent. Use [2, 3].
#var max_trauma = 4.0
var max_trauma = 6.0
var noise = FastNoiseLite.new()
var noise_y = 0

#######



var player = null

func _ready():
	#######
	randomize()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	noise.frequency = 4.0
	#######
	
	
	Global.death_zone = limit_bottom + 200
	enabled = true

func _physics_process(_delta):
	player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		zoom = Vector2(2.0,2.0)
		global_position = player.global_position
	else:
		zoom = Vector2(1,1)
		position = Vector2(0,0)
		
		
func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
func shake():
	var amount = pow(min(trauma,1.0), trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(1, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(3, noise_y)
  
func add_trauma(amount):
	trauma = min(trauma + amount, max_trauma)
	#trauma = max(trauma + amount, max_trauma)
	
		



"""
extends Camera2D

# Originally developed by Squirrel Eiserloh (https://youtu.be/tu-Qe66AvtY)
# Refined by KidsCanCode (https://kidscancode.org/godot_recipes/2d/screen_shake/)

var decay = 5							# How quickly the shaking stops
var max_offset = Vector2(15, 0)			# Maximum hor/ver shake in pixels.
var max_roll = 0.05						# Maximum rotation in radians (use sparingly).

var trauma = 0.0						# Current shake strength.
var trauma_power = 3					# Trauma exponent. Use [2, 3].
var max_trauma = 4.0
var noise = FastNoiseLite.new()
var noise_y = 0

func _ready():
	randomize()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	noise.frequency = 4.0

func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
	
func shake():
	var amount = pow(min(trauma,1.0), trauma_power)
	noise_y += 1
	rotation = max_roll * amount * noise.get_noise_2d(1, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(3, noise_y)
  
func add_trauma(amount):
	trauma = min(trauma + amount, max_trauma)
	
"""

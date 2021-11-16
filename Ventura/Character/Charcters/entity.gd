extends KinematicBody2D
class_name Event_Characters


export var MAX_SPEED = 300
var acceleration = 3000
var motion = Vector2.ZERO
var screensize
var is_enemy_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size
	#position = Vector2(screensize.x/2,(screensize.y * 2) / 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	motion.clamped(MAX_SPEED)

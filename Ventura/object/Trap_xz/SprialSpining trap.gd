extends Trap
class_name Spiral_Trap

var body_rotation
var move_speed=170
var velocity= Vector2()
var INITIAL_GLOBAL=Vector2()
var along_x
var along_y
var sound 

onready var parent=get_parent()

func _ready() -> void:
	sound = AudioStreamPlayer2D.new()
	self.add_child(sound)
	sound.stream = load('res://Audio and sound effects/chainsawtrap.ogg')
	sound.set_volume_db(-20)
	sound.play()
	INITIAL_GLOBAL.x=global_position.x
	INITIAL_GLOBAL.y=global_position.y
	set_movement_and_rotation(1,0,0,1,1,1,1)
	set_physics_process(true)
	

func _physics_process(delta: float) -> void:
	body_rotation=get_rotation_degrees()+10
	set_rotation_degrees(body_rotation)
	var collision_info=move_and_collide(velocity.normalized()*move_speed*delta)
	if collision_info:
		#var trap=get_slide_collision(0).collider as Trap_Map
		#if trap:
			velocity.x=-velocity.x
			velocity.y=-velocity.y
	
func check_distance_in_x(INITIAL_GLOBAL_X: int, position_of_x):
	return position_of_x-INITIAL_GLOBAL_X
	
func check_distance_in_y(INITIAL_GLOBAL_Y: int, position_of_y):
	return position_of_y-INITIAL_GLOBAL_Y

func set_movement_and_rotation(direction_x,direction_y,body_rotation_given,scale_x,scale_y,final_scale_in_x,final_scale_in_y):
	along_x=direction_x
	along_y=direction_y
	body_rotation=0
	velocity.x=along_x
	velocity.y=along_y

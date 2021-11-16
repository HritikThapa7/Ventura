extends Node2D

var audio
onready var Character_collection = $NPC_collection

func _ready():
	set_process(true)
	set_camera_limits()
	audio = AudioStreamPlayer2D.new()
	$Player.add_child(audio)
	$NPC_collection/NPC1/CanvasLayer/DialogBox.set_visible(true)
	
func _process(delta):
	if global.is_inside_area and global.is_talkable:
		if Input.is_action_just_pressed("Z_button"):
			$NPC_collection/NPC1._dialogs()
			print("z button pressed")
			audio.stream = load("res://Audio and sound effects/select_sound.wav")
			audio.set_volume_db(10)
			audio.play()
			var index=int(global.area_entered_name[-1])
			print("asdasdasda", index)
			$NPC_collection.get_child(index-1)._dialogs()

func set_camera_limits():
	var map_limits=$"Tilemap collection/Grass".get_used_rect()
	var map_cellsize=$"Tilemap collection/Grass".cell_size
	$Player/Camera2D.limit_left=map_limits.position.x*map_cellsize.x
	$Player/Camera2D.limit_right=map_limits.end.x*map_cellsize.x
	$Player/Camera2D.limit_top=map_limits.position.y*map_cellsize.y
	$Player/Camera2D.limit_bottom=map_limits.end.y*map_cellsize.y

extends Node2D
class_name Main_Scene_4

onready var Tilemap_collection=get_node("Tilemap collection")
onready var Spawning_area_collection=get_node("Spawning area colection")
onready var Character_collection=get_node("Character_collection")
var audio

func _ready():
	audio = AudioStreamPlayer2D.new()
	$Player.add_child(audio)
	set_camera_limits();
	set_process(true);
	for i in range(0,Character_collection.get_child_count()):
		Character_collection.get_child(i).get_node("AnimatedSprite").play("right")

func set_camera_limits():
	var map_limits=$"Tilemap collection/grass".get_used_rect()
	var map_cellsize=$"Tilemap collection/grass".cell_size
	$Player/Camera2D.limit_left=map_limits.position.x*map_cellsize.x
	$Player/Camera2D.limit_right=map_limits.end.x*map_cellsize.x
	$Player/Camera2D.limit_top=map_limits.position.y*map_cellsize.y
	$Player/Camera2D.limit_bottom=map_limits.end.y*map_cellsize.y
	
func _process(delta):
	if global.is_inside_area and global.is_talkable:
		if Input.is_action_just_pressed("Z_button"):
			print("z button pressed")
			audio.stream = load("res://Audio and sound effects/select_sound.wav")
			audio.set_volume_db(10)
			audio.play()
			var index=int(global.area_entered_name[-1])
			Character_collection.get_child(index-1)._dialogs()

func _on_shoot(bullet, _position, _direction):
	var b=bullet.instance()
	add_child(b)
	b.start(_position,_direction)
	
func _on_Area2D_player_entered(area: Area2D) -> void:
	var enemy_spawnin_node=area.get_node("Enemy_Collection")
	for i in range(0, enemy_spawnin_node.get_child_count()):
		print(enemy_spawnin_node.get_child(i).name)
		enemy_spawnin_node.get_child(i).set_visible(true);



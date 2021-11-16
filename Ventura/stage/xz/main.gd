extends Node2D
class_name Main_scene_1

#onready var Enemies=preload("res://Character/EnemyFollowsU.tscn")
onready var Tilemap_collection=get_node("Tile map collection")
onready var Character_collection=get_node("Charcter_collection")
onready var Event_item_collection=get_node("Event_item_collection")
onready var Spawing_area_collection=get_node("Spawning_area_collection")
onready var player=get_node("Player")
var audio

onready var spawned=false

func _ready() -> void:
	$waterfall/AudioStreamPlayer2D.play()
	audio = AudioStreamPlayer2D.new()
	$Player.add_child(audio)
	set_process(true)
	set_camera_limits()

func _process(delta: float) -> void:
	randomize()
	if global.is_inside_area and global.is_talkable:
		if Input.is_action_just_pressed("Z_button"):
			print("z button pressed")
			audio.stream = load("res://Audio and sound effects/select_sound.wav")
			audio.set_volume_db(10)
			audio.play()
			var index=int(global.area_entered_name[-1])
			Character_collection.get_child(index-1)._dialogs()
	
	if global.is_present(global.event_collection,'Event_2'):
		for i in range(0,Event_item_collection.get_child_count()):
			print(Event_item_collection.get_child(i).name)
			Event_item_collection.get_child(i).queue_free()
			
func _on_shoot(bullet, _position, _direction):
	var b=bullet.instance()
	add_child(b)
	b.start(_position,_direction)
	
func set_camera_limits():
	var map_limits=$"Tile map collection/Grass".get_used_rect()
	var map_cellsize=$"Tile map collection/Grass".cell_size
	$Player/Camera2D.limit_left=map_limits.position.x*map_cellsize.x
	$Player/Camera2D.limit_right=map_limits.end.x*map_cellsize.x
	$Player/Camera2D.limit_top=map_limits.position.y*map_cellsize.y
	$Player/Camera2D.limit_bottom=map_limits.end.y*map_cellsize.y
		
			

func _on_Area2D_player_entered(area: Area2D) -> void:
	var enemy_spawnin_node=area.get_node("Enemy_Collection")
	for i in range(0, enemy_spawnin_node.get_child_count()):
		enemy_spawnin_node.get_child(i).set_visible(true);

func _on_town_area_player_entered(shooting_condition) -> void:
	print("Signal_caaught")
	player.shoot_condition(shooting_condition)


func _on_town_area_player_exited(shooting_condition) -> void:
	print("Signal_caaught")
	player.shoot_condition(shooting_condition)

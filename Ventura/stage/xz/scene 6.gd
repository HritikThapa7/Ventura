extends Node2D

onready var Tilemap_collection= get_node("Tilemap_colection")
onready var door_collection=get_node("door collection")

func _ready():
	set_camera_limits()
	$"SprialSpinnig Collection".get_child(0).set_movement_and_rotation(0,1,0,1,1,1,1)
	$"SprialSpinnig Collection".get_child(1).set_movement_and_rotation(0,1,0,1,1,1,1)
	$"SprialSpinnig Collection".get_child(2).set_movement_and_rotation(0,-1,0,1,1,1,1)
	$"SprialSpinnig Collection".get_child(3).set_movement_and_rotation(0,1,0,1,1,1,1)
	$"SprialSpinnig Collection".get_child(4).set_movement_and_rotation(0,-1,0,1,1,1,1)
	$"SprialSpinnig Collection".get_child(5).set_movement_and_rotation(0,-1,0,1,1,1,1)
	
	$"Moving Trap Collection".get_child(0).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(1).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(2).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(3).set_movement_and_rotation(0,0,0,1,1,1,6)
	$"Moving Trap Collection".get_child(4).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(5).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(6).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(7).set_movement_and_rotation(0,0,0,1,1,1,8)
	$"Moving Trap Collection".get_child(8).set_movement_and_rotation(0,0,0,1,1,1,6)
	
func set_camera_limits():
	var map_limits=$Tilemap_colection/Dark.get_used_rect()
	var map_cellsize=$Tilemap_colection/Dark.cell_size
	$Player/Camera2D.limit_left=map_limits.position.x*map_cellsize.x
	$Player/Camera2D.limit_right=map_limits.end.x*map_cellsize.x
	$Player/Camera2D.limit_top=map_limits.position.y*map_cellsize.y
	$Player/Camera2D.limit_bottom=map_limits.end.y*map_cellsize.y
	
func _on_shoot(bullet, _position, _direction):
	var b=bullet.instance()
	add_child(b)
	b.start(_position,_direction)
	
func _on_Area2D_player_entered(area: Area2D) -> void:
	var enemy_spawnin_node=area.get_node("Enemy Collection")
	for i in range(0, enemy_spawnin_node.get_child_count()):
		enemy_spawnin_node.get_child(i).set_visible(true);

func check_door_condition(platform_name: String):
	print("Signal Caught")
	var platform_index=int(platform_name[-1])-1
	print(platform_index)
	door_collection.get_child(platform_index).check_door()

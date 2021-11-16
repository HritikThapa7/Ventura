extends Node2D

onready var Player=get_node("Player_xy_1")
onready var bgmusic = $Player_xy_1/AudioStreamPlayer2D
var key_found=false
var key_found2=false

func _ready():
	pass

func _physics_process(delta):
#	var  pos=Player.position
#
#	if Player.position.y>1000:
#
#
#		Player.dead()
#		Player.position=Vector2(0,500)
	pass

		

	

func _on_door_In_door_area(value1:bool):

	if value1==true:
		if key_found==true:
			print("Inside Door func")
			$door/Timer.start()
			$door/spikeA.set_visible(false)
			$door.queue_free()

	 
		


func _on_key_key_found(value:bool):
	
	if value==true:
		key_found=true
		print("inside key")
		$key.queue_free()
		global.event_collection.append("Event 3")





func _on_Treasurefound_treasure_found(value:bool):
	if value==true:
		$HiddenWall.set_visible(true)
		$HiddenWall.set_collision_layer_bit(15,true)
		$HiddenWall.set_collision_mask_bit(0,true)
	

func _on_door2_In_door_area2(value:bool):
		if value==true:
			if key_found2==true:
				print("Inside Door func")
				$door2/Timer.start()
				$door2/Sprite.set_visible(false)
				$door2.queue_free()

	

func _on_key2_key_found2(value:bool):
	
		if value==true:
			key_found2=true
			print("inside key")
			$key2.queue_free()

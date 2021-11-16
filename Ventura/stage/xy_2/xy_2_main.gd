extends Node2D
var key_found = false
var in_door = false

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_key_xy_2_key_found(value:bool):
	if value == true:
		key_found = true
		print("key_found true")
		$key_xy_2.queue_free()
		$door_xy_2/AnimatedSprite.set_visible(true)
		
	

func _on_door_xy_2_in_door_area(value1:bool):
	if value1 == true:
		if key_found == true:
			in_door = true
			print("I am in door")
			$door_xy_2/sprite_collision.queue_free()

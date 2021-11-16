extends StaticBody2D
class_name Door

var door_closed=true

func check_door():
	if door_closed:
		open_door()
	else:
		close_door()

func open_door():
	hide()
	door_closed=false
	set_collision_layer_bit(3,false)
	set_collision_mask_bit(0,false)
	
func close_door():
	show()
	door_closed=true
	set_collision_layer_bit(3,true)
	set_collision_mask_bit(0,true)

extends KinematicBody2D

signal In_door_area(value)
func _ready():
	pass


#func _on_Area2D_area_entered(area):
#	print("door")
	#emit_signal("In_door_area",true)
	#print("signal emited")



func _on_Area2D_body_entered(body):
	
	emit_signal("In_door_area",true)
	


func _on_Timer_timeout():
	queue_free()
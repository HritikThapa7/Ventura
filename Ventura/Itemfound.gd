extends Area2D

signal item_found(value)
func _ready():
	pass




func _on_Timer_timeout():
	queue_free()




func _on_Itemfound_body_entered(body):
	if "Player" in body.name:
		print("Key found to open the door")
		emit_signal("item_found",true)
	

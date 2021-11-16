extends Area2D

signal key_found(value)
func _ready():
	pass




func _on_Timer_timeout():
	queue_free()


func _on_key_body_entered(body):
	if "Player" in body.name:
		print("Key found to open the door")
		emit_signal("key_found",true)



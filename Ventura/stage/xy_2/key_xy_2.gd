extends Area2D

signal key_found(value)




func _ready():
	pass # Replace with function body.



func _on_Timer_timeout():
	queue_free()


func _on_key_xy_2_body_entered(body):
	if "player" in body.name:
		print("key found")
		emit_signal("key_found", true)

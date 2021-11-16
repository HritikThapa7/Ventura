extends KinematicBody2D

signal in_door_area(value)
func _ready():
	$AnimatedSprite.set_visible(false)
	
	pass 
	



func _on_Area2D_body_entered(body):
	if "player" in body.name:
		print("inside door area")
		emit_signal("in_door_area", true)


func _on_Timer_timeout():
	queue_free()

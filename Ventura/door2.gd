extends KinematicBody2D

signal In_door_area2(value)

func _ready():
	pass

func _on_Area2D_body_entered(body):
	emit_signal("In_door_area2",true)



func _on_Timer_timeout():
	queue_free()


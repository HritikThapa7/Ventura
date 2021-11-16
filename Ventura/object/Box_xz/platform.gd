extends Area2D
class_name Platform

signal pressed(platform_name)
signal unpressed(platform_name)
var is_hidden=false

func _on_platform_body_entered(body: PhysicsBody2D) -> void:
	if body is Box or body.get_name()=="Player":
		print("Body entered")
		emit_signal("pressed",get_name())
		hide()
		is_hidden=true
	else:
		return


func _on_platform_body_exited(body: PhysicsBody2D) -> void:
	if is_hidden:
		show()
		is_hidden=false
		emit_signal("unpressed",get_name())

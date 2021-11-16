extends Area2D

signal player_entered
signal player_exited
func _ready() -> void:
	pass # Replace with function body.


func _on_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		emit_signal("player_exited",true)


func _on_town_area_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		emit_signal("player_entered",false)

func _on_town_area_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		emit_signal("player_exited",true)
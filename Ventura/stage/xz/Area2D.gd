extends Area2D
signal player_entered

onready var full_spawn=false

func _ready() -> void:
	pass


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		emit_signal("player_entered",self)
		print("signal_emitted")

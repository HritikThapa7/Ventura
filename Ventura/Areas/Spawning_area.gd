extends Area2D

onready var spawning_enemies= preload("res://Character/EnemyFollowsU.tscn")


func _ready() -> void:
	pass # Replace with function body.



func _on_Spawning_area_body_entered(body: PhysicsBody2D) -> void:
	var s= spawning_enemies.instance()
	get_node("Enemy_Collection").add_child(s)

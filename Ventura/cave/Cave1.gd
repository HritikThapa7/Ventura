extends Area2D

var enter = false

func _ready():
	pass

func _process(delta):
	if enter:
		get_tree().change_scene("res://stage/xy_A/Stage.tscn")

func _on_Cave1_body_entered(body):
	if body is Player:
		$AudioStreamPlayer2D.play()
		enter = true

extends Area2D

var enter = false

func _ready():
	pass

func _process(delta):
	if enter:
		get_tree().change_scene("res://stage/xy_2/xy_2_main.tscn")


func _on_cave2_body_entered(body):
	if body is Player:
		$AudioStreamPlayer2D.play()
		enter = true

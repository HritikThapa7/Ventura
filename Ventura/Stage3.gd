extends Area2D
var enter=false

func _ready():
	pass


		

func _on_Stage3_body_entered(body):
		if  "Player_xy_1" in body.name:
			get_tree().change_scene("res://stage/xz/Scene_3.tscn")
			


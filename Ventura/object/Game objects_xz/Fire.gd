extends "res://src/Entities/Enemy.gd"

var movement = Vector2.ZERO
var to_move = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if self.name == "Fire_1":
		if to_move:
			position.y += 2
	elif self.name == "Fire_2":
		if to_move:
			position.x -= 2
			position.y += 2
	elif self.name == "Fire_3":
		if to_move:
			position.x += 2
			position.y += 2
			
	if position.y > 300:
		to_move = false
		position = Vector2(1,0)
		$coin.set_visible(false)


func _on_Timer_timeout() -> void:
	to_move = true
	$coin.set_visible(true)
	#print("Fire reload")


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		$coin.set_visible(false)
	else:
		pass

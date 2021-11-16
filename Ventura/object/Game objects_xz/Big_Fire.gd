extends KinematicBody2D

var to_move = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if to_move:
		position.y += 2
	
	if position.y > 350:
		to_move = false
		position = Vector2(1,0)
		$big_fire.set_visible(false)

func _on_Timer_timeout() -> void:
	$big_fire.set_visible(true)
	to_move = true


func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		$big_fire.set_visible(false)
	else:
		pass

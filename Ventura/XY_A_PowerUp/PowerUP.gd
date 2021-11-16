extends Area2D


func _ready():
	$AnimatedSprite.play("idle")
func _process(delta)->void:
	pass

func _on_PowerUP_body_entered(body):
	if "Player" in body.name:
		body.crown_power_up()
		queue_free()

extends Node2D
const SPEED=500
var velocity=Vector2()
var direction = 1


func set_fireball_direction(dir):
	direction=dir
	if dir == -1:
		$AnimatedSprite.flip_h= true
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x=SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("fire")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

	


func _on_Fireball2_body_entered(body):
	if "enemy" in body.name:
		body.dead(2)
	queue_free()

extends Area2D

const SPEED=250
var velocity=Vector2()
var direction = 1
var to_move=true
var  pos=0.0

func set_fireball_direction(dir):
	direction=dir
	if dir == -1:
		$AnimatedSprite.flip_h = true
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if to_move:
		velocity.x=SPEED * delta * direction
		translate(velocity)
		
		pos+=position.y
	if pos>10000:
		to_move=false
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	
	queue_free()


func _on_enemyBullet_body_entered(body):
	if "Player" in body.name:
		body.damage(0.5)
	queue_free()

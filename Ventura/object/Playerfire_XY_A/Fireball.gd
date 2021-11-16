extends Node2D
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
		$AnimatedSprite.play("shoot")
		pos+=position.y
	if pos>6000:
		to_move=false
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	
	queue_free()

func _on_Fireball_body_entered(body):
	
	if "enemy" in body.name:
		
			body.dead(1)
	elif "enemyRay" in body.name:
		body.dead(1)
		
	elif "enemAI" in body.name:
		body.damage(30)
	
		
	 
		
	queue_free()





		
		
	
	
	
	




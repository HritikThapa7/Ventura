extends KinematicBody2D

const GRAVITY = 0
const FLOOR = Vector2(0,-1)

export(int) var  speed = 400
export(int) var hp = 1
export(Vector2) var size = Vector2(0.45,0.45)



var direction = 1

var velocity = Vector2()

var is_dead = false

func dead():
	hp -= 1
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$enemy_AnimatedSprite.play("dead")
		$CollisionShape2D.call_deferred("set_disabled",true)
		$Timer.start()
		if scale > Vector2(0.45,0.45):
			get_parent().get_node("Screenshake").screen_shake(1, 10, 100)

func _ready():
	scale = size
	#$RayCast2D.set_deferred("enabled",false)
	pass 
	
	
func _physics_process(delta):
	if is_dead == false:
		velocity.x = speed * direction
		
		if direction == 1:
			$enemy_AnimatedSprite.flip_h = false
		else:
			$enemy_AnimatedSprite.flip_h = true
		$enemy_AnimatedSprite.play("walk")
		
		velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		direction *= -1
#		$RayCast2D.position.x *= -1

		
#	if $RayCast2D.is_colliding() == false:
#		direction *= -1
#		$RayCast2D.position.x *= -1
		
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()

	


func _on_Timer_timeout():
	queue_free()

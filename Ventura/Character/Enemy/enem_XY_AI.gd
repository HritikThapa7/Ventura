extends KinematicBody2D

signal killed()
signal health_update(health)

export var max_health=299
var is_dead=false

onready var health = max_health setget _set_health

enum  {
		Idle,
		Move,
		New_direction,
		Attack1,
		Attack2,
	
	}

var state=Move
const SPEED = 30
var direction=Vector2.RIGHT
var count=0
const FIREBALL =preload("res://object/Enemy_bullet_XY_A/enemyBullet.tscn")
var fireball=null
func _ready():
	randomize()

func _process(delta):
	if get_slide_count()>0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.damage(20)
	match state:
		Idle:
			pass
		New_direction:
			direction=choose([Vector2.RIGHT,Vector2.LEFT])
			state = choose([Idle,Move,Attack1,Attack2])
			
		Move:
			move(delta)
		Attack1:
			fireball=FIREBALL.instance()
			fireball.set_fireball_direction(1)
			get_parent().add_child(fireball)
			fireball.position=$Position2D2.global_position
			yield(get_tree().create_timer(4),"timeout")
		Attack2:
			fireball=FIREBALL.instance()
			
			fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position=$Position2D1.global_position
			yield(get_tree().create_timer(4),"timeout")
	
func move(delta):
	if is_on_wall():
		direction*=-1
		print("Worked")
	else:
		position +=direction*SPEED*delta
	
func choose(array):
	array.shuffle()
	return array.front()
func dead():
	is_dead = true
	position= Vector2(0,0)
	
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func killed():
	dead()
	
func _set_health(value):
	var prev_health =health
	health =clamp(value,0,max_health)
	print(health)
	if health != prev_health:
		emit_signal("health_update",health)
		if health== 0:
			killed()
			emit_signal("killed")
	
func damage(amount):
	
	_set_health(health -amount)
	$AnimatedSprite.play("hurt")
	print("Health remaining of enemyAI " +str(health))

func _on_Timer_timeout():
	$Timer.wait_time=choose([0.5,0.3,0.6,0.9,1,0.63])
	state = choose([Idle,Attack1,Attack2,New_direction,Move])

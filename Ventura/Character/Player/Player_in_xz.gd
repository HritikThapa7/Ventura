extends Player
class_name Player_in_xz

signal shoot

onready var tween=get_node("Tween")

export (PackedScene) var Bullet
export (float) var shoot_cooldown
export var move_speed=1500
export var push_speed=120.0
export var hit_speed=120.0
export var friction=-300
export var MAX_SPEED=350
export var HEALTH=1000

var motion=Vector2()
var before_direction=Vector2()
var direction=Vector2()
var Position2d_position=Vector2(35,35)
var ideal_state
var walking
var shoot
var music
var hit_taken
var inside_area = ['none']

var shooting = true
var can_shoot=true
var facing="front"

func _ready() -> void:
	audio_loader()
	in_which_plane()
	print(HEALTH)
	$Shooting_timer.wait_time=shoot_cooldown
	set_physics_process(true)
	$AnimatedSprite.play("ideal_front",true)
	$"firing direction".set_visible(false)

func _physics_process(delta: float) -> void:
	before_direction=direction
	direction=calculate_normalized_direction()
	if Input.is_action_pressed("shoot_ready") and shooting:
		$"firing direction".set_visible(true)
	else:
		$"firing direction".set_visible(false)
	if abs(direction.x)+abs(direction.y)<2:
		if Input.is_action_just_pressed("shoot") and Input.is_action_pressed("shoot_ready"):
			shoot()
		if Input.is_action_just_pressed("boost"):
			MAX_SPEED=450.0
			walking.stream = load('res://Audio and sound effects/walking-[AudioTrimmer.com].wav')
		if Input.is_action_just_released("boost"):
			MAX_SPEED=350.0
			if inside_area:
				if inside_area[-1] == 'forest':
					walking.stream = load('res://Audio and sound effects/forest_walking.wav')
			else:
				walking.stream = load('res://Audio and sound effects/walking.wav')
		
		update_animation(direction,before_direction)
		set_position2d()
		motion=calculate_motion(direction,move_speed,delta)
		motion=limit_velocity(motion)
		move_and_slide(motion)
		if get_slide_count()>0:
			check_box_collision(direction)
		if get_slide_count()==1:
			check_trap_collision(direction)
	else:
		print("cannot move")

func audio_loader():
	music = AudioStreamPlayer2D.new()
	self.add_child(music)
	hit_taken = AudioStreamPlayer2D.new()
	self.add_child(hit_taken)
	hit_taken.stream = load('res://Audio and sound effects/impact.wav')
	walking = AudioStreamPlayer2D.new()
	self.add_child(walking)
	walking.stream = load('res://Audio and sound effects/walking.wav')
	shoot = AudioStreamPlayer2D.new()
	self.add_child(shoot)
	shoot.stream = load('res://Audio and sound effects/magic_fire.wav')

func calculate_normalized_direction() -> Vector2:
	var new_motion= Vector2()
	new_motion.x=Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	new_motion.y=Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	return new_motion

func calculate_motion(direction: Vector2, move_speed: float,delta: float)-> Vector2:
	var vel=Vector2()
	direction.x=direction.x*move_speed
	direction.y=direction.y*move_speed
	if direction.x==0 and direction.y==0:
		direction.x=vel.x*friction
		direction.y=vel.y*friction
	vel.x=vel.x+direction.x
	vel.y=vel.y+direction.y
	return vel

func limit_velocity(velocity:Vector2):
	#USED TO LIMIT THE VELOCITY OF THE CHARACTER TO THE MAX SPEED
	velocity.x=clamp(velocity.x,-MAX_SPEED,MAX_SPEED)
	velocity.y=clamp(velocity.y,-MAX_SPEED,MAX_SPEED)
	return velocity

	
func check_box_collision(direction: Vector2):
	if abs(direction.x)+abs(direction.y)>1:
		return
	var box:= get_slide_collision(0).collider as Box
	if box:
		box.push(direction.normalized()*push_speed)
	pass

func check_trap_collision(direction: Vector2):
	var trap:= get_slide_collision(0).collider as Trap 
	if trap:
		var move_to=calculate_position_after_hit(direction)
		print(move_to)
		tween.interpolate_property(self,"position",get_position(),move_to,0.1,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
		tween.start()
		yield(tween,"tween_completed")
		#opacity_decrease()
		when_hit()
	pass
		
func update_animation(direction,before_direction):
	if direction.x==0 and direction.y==0 and $AnimatedSprite.is_playing():
		walking.stop()
		if before_direction.x>0:
			$AnimatedSprite.stop()
			$AnimatedSprite.play("ideal_right")
		if before_direction.x<0:
			$AnimatedSprite.stop()
			$AnimatedSprite.play("ideal_left")
		if before_direction.y>0:
			$AnimatedSprite.stop()
			$AnimatedSprite.play("ideal_front")
		if before_direction.y<0:
			$AnimatedSprite.stop()
			$AnimatedSprite.play("ideal_back")
	else:
		if !walking.playing:
			walking.play()
		if direction.x<0:
			$AnimatedSprite.play("walking left")
		if direction.x>0:
			$AnimatedSprite.play("walking_right")
		if direction.y<0:
			$AnimatedSprite.play("walking_back")
		if direction.y>0:
			$AnimatedSprite.play("walking_front")
		
func when_hit():
	HEALTH-=10
	print("Remaining Health: "+ str(HEALTH))

func calculate_position_after_hit(direction: Vector2):
	if direction==Vector2(0,0):
		return Vector2(get_position().x-50,get_position().y-50)
	else:
		return Vector2(get_position().x+(direction.x*-50),get_position().y+(direction.y*-50))
		
	
func damage(damage):
	$Hit.set_visible(true)
	$"Hit timer".start(0.2)
	hit_taken.play()
	print (HEALTH)
	HEALTH-=damage
	if HEALTH<=0:
		queue_free()
	
func set_position2d():
	$"firing direction".look_at(get_global_mouse_position())
	
func shoot_condition(shooting_condition: bool):
	print(shooting_condition)
	shooting=shooting_condition

func shoot():	
	if can_shoot and shooting:
		shoot.play()
		can_shoot = false
		$Shooting_timer.start()
		var dir = Vector2(1, 0).rotated($"firing direction".global_rotation)
		emit_signal('shoot', Bullet, $"firing direction/Firing".global_position, dir)

func _on_Timer_timeout() -> void:
	can_shoot=true


func _on_Bullet_area_area_entered(area: Area2D) -> void:
	if area is EnemyBullet:
		print("Hit taken")
		damage(area.damage)
	pass


func _on_Hit_timer_timeout() -> void:
	$Hit.set_visible(false)
	
func in_which_plane():
	print("in xz plane")


func _on_Area2D_area_entered(area):
	if area.name == 'village':
		music.set_volume_db(10)
		music.stream = load('res://Audio and sound effects/village.ogg') 
		music.play()
		inside_area.append(area.name)
	elif area.name == 'forest':
		walking.stream = load('res://Audio and sound effects/forest_walking.wav')
		music.set_volume_db(0)
		music.stream = load('res://Audio and sound effects/forest_noise.ogg')
		music.play()
		inside_area.append(area.name)
	elif area.name == 'wizard_place':
		music.set_volume_db(0)
		music.stream = load('res://Audio and sound effects/wizard_mystery.ogg')
		music.play()


func _on_Trap_hit_body_entered(body):
	if body is Trap:
		print("Hit taken")
		damage(10)
	pass

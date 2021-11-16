extends  Player
signal health_update(health)
signal killed()
const SPEED=350
const GRAVITY=10
const JUMP_POWER =-570
const FLOOR = Vector2(0,-1)

const FIREBALL =preload("res://object/Playerfire_XY_A/Fireball.tscn")
const FIREBALL2=preload("res://object/Playerfire_XY_A/Fireball2.tscn")
var is_attacking =false
##
var on_ground= false
var is_dead = false
var fireball_power=1
var is_walking=false
export var velocity = Vector2()
export (float) var max_health =100

onready var health = max_health setget _set_health
onready var invulnerability_timer =Timer
onready var hp_bar=get_node("HealthBar")
onready var tween=get_node("HealthBar/Tween")
onready var dialog = $CanvasLayer/DialogBox


var hppercent=null
var rate_of_fire1=0.5 
var can_fire=true


func _ready():
	$AnimatedSprite.play("idle")


func _physics_process(delta):
	
	
	
	if is_dead == false:
		
		if Input.is_action_pressed(("ui_right")):
			is_walking=true
			if is_attacking==false || is_on_floor()==false:
			
				velocity.x=SPEED
				if is_attacking==false:
						
					$AnimatedSprite.play("run")
					$AnimatedSprite.flip_h=false
					if sign($Position2D.position.x)== -1:
						$Position2D.position.x *= (-1)
				
	
			
		elif Input.is_action_pressed(("ui_left")):
			is_walking=true
			if is_attacking==false || is_on_floor()==false:
				velocity.x=-SPEED
				
				if is_attacking==false:
					
					$AnimatedSprite.flip_h=true
					$AnimatedSprite.play("run")
					if sign($Position2D.position.x)== 1:	
						$Position2D.position.x *= (-1)
						
		elif Input.is_action_pressed("ui_select") :
			is_walking=true
			if is_attacking==false || is_on_floor()==false:
				if sign($Position2D.position.x)== 1:
					$AnimatedSprite.play("run")
					velocity.x=SPEED*3
					
					
				elif sign($Position2D.position.x)== -1:
					$AnimatedSprite.play("run")
					velocity.x=-SPEED*3
					
		else:
			velocity.x=0
			is_walking=false
			if on_ground == true:
				$AnimatedSprite.play("idle")
			
			
				
				
		if Input.is_action_pressed(("ui_up")):
			if on_ground==true:
				velocity.y = JUMP_POWER
				on_ground=false 
		
				
				
			
			
		var fireball=null
		
		if Input.is_action_just_pressed("ui_focus_next") and can_fire==true :
			if is_walking==false:
				can_fire=false
				if is_on_floor():
					 velocity.x=0
				
				if fireball_power==1:
					 fireball=FIREBALL.instance()
					
				elif fireball_power==2:
					 fireball=FIREBALL2.instance()
					 
			
				if sign($Position2D.position.x) == 1:
					fireball.set_fireball_direction(1)
				else:
					fireball.set_fireball_direction(-1)
				get_parent().add_child(fireball)
				fireball.position=$Position2D.global_position
				$AnimatedSprite.play("attack")
			
				
				can_fire=true
	
		velocity.y +=  GRAVITY
		if is_on_floor():
			on_ground = true
		else:
			on_ground = false
			if velocity.y < 0:
				$AnimatedSprite.play("jump")
			else:
				$AnimatedSprite.play("fall")
			
		
		velocity = move_and_slide(velocity,FLOOR)
#
			
		
		if get_slide_count()>0:
			for i in range(get_slide_count()):
				if "enemy_xy_A1" in get_slide_collision(i).collider.name:
					damage(40)
		
		if get_slide_count()>0:
			for i in range(get_slide_count()):
				if "water_flowing_XY_A" in get_slide_collision(i).collider.name:
					dead()
		
		if get_slide_count()>0:
			for i in range(get_slide_count()):
				if "SizeChangeTrap" in get_slide_collision(i).collider.name:
					damage(2)
		
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	hp_bar.value=0
	$AnimatedSprite.play("dead")
	
	
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _on_AnimatedSprite_animation_finished():
	is_attacking=false
	


func _on_Timer_timeout():
	get_tree().change_scene("res://stage/xz/main.tscn") #to scene where it again need to start

func crown_power_up():
	fireball_power=2
func damage(amount):
	
	_set_health(health -amount)
	$AnimatedSprite.play("hurt")
	print("Health remaining " +str(health))
	
func killed():
	dead()
func _set_health(value):
	var prev_health =health
	health =clamp(value,0,max_health)
	HPBarUpdate()

	print(health)
	if health != prev_health:
		emit_signal("health_update",health)
		if health== 0:
			killed()
			emit_signal("killed")
			hp_bar.hide()

func HPBarUpdate():
		hppercent=int((float(health)/max_health)*100)
		tween.interpolate_property(hp_bar,"value",hp_bar.value,hppercent,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
		tween.start()
		hp_bar.value=hppercent
		if hppercent>=60:
			hp_bar.set_tint_progress("14e114")
		elif hppercent>=30:
			hp_bar.set_tint_progress("e1be32")
		else:
			hp_bar.set_tint_progress("e11e1e")
			



func _on_Area2D_area_entered(area):
	if area.name == "Area1":
		dialog.set_visible(true)
		dialog.get_node("Text").set_bbcode(dialog.xy_1[0])
		dialog.get_node("Text").set_visible_characters(0)
	
	if area.name == "Area2":
		dialog.set_visible(true)
		dialog.get_node("Text").set_bbcode(dialog.xy_[2])
		dialog.get_node("Text").set_visible_characters(0)


func _on_Area2D_area_exited(area):
	dialog.set_visible(false)

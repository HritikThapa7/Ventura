extends Shooter
class_name Enemy

signal shoot 

onready var timer=$Timer
onready var enemy=$AnimatedSprite

export var damage=15
export var enemey_speed=100
export var attack_distance=250
export var min_move_distance=70.00

var player : Player
var sound

func _ready():
	sound = AudioStreamPlayer2D.new()
	self.add_child(sound)
	sound.stream = load('res://Audio and sound effects/enemystar.wav')
	print(health)
	set_physics_process(false)
	$AnimatedSprite.play("start")

func _physics_process(delta):
	
	var direction = (player.global_position-global_position).normalized()
	var distance_to_player=global_position.distance_to(player.global_position)
	var curr_dir= Vector2(1,0). rotated($"firing direction".global_rotation)
	$"firing direction".global_rotation=curr_dir.linear_interpolate(direction,50*delta).angle()
	
	if direction.dot(curr_dir)>0.9:
		shoot()
	
	if distance_to_player >= min_move_distance:
		move_and_collide(direction* enemey_speed*delta)

	
func _on_Area2D_body_entered(body):
	sound.play()
	if body is Player:
		player=body
		set_physics_process(true)
		 


func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		set_physics_process(false)
		
func shoot():
	if can_shoot:
		can_shoot = false
		$GunTimer.start()
		var dir = Vector2(1, 0).rotated($"firing direction".global_rotation)
		emit_signal('shoot', Bullet, $"firing direction/Firing".global_position, dir)

func _on_GunTimer_timeout() -> void:
	can_shoot=true
	
func damage(damage):
	print(health)
	health-=damage
	if health==0:
		self.queue_free()
		
	

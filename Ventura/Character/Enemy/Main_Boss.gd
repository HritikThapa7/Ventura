extends KinematicBody2D

signal shoot

export(PackedScene) var FireBall_1
export(PackedScene) var Fireball_2
export (float) var speed
export (float) var firing_speed
export (float) var health
var dir

var can_shoot=true

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	pass
	
func shoot():
	if can_shoot:
		can_shoot=false
		$GunTimer.start()
		emit_signal('shoot', FireBall_1, $"firing direction/Firing".global_position, dir)

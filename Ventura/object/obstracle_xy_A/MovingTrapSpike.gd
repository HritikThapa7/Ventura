extends Node2D
const IDLE_DURATION =1.0
const TILE=40
export var move_to = Vector2.RIGHT*450
export var speed=3
onready var platform=$platform
onready var tween = $Tween
var follow = Vector2.ZERO
func _ready()->void:
	_init_tween()
	
func _init_tween():
	var duration =move_to.length()/float(speed * TILE)
	tween.interpolate_property(self,"follow",Vector2.ZERO,move_to,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self,"follow",move_to,Vector2.ZERO,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,duration + IDLE_DURATION*2)
	tween.start()

func _physics_process(delta)->void:
	platform.position=platform.position.linear_interpolate(follow,0.1)

func _on_platform_body_entered(body):
	if "Player" in body.name:
		body.damage(30)

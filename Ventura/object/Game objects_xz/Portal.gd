extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer
export var is_open = false
var used_portal = false

func _ready() -> void:
	set_visible(false)

func _process(delta: float) -> void:
	pass

func _on_Portal2D_body_entered(body: PhysicsBody2D) -> void:
	if visible:
		used_portal = true
		print("portal entered")
		body.position.x = 268.063
		body.position.y = 300.014
		anim_player.play("Fade_In")
		yield(anim_player , "animation_finished")

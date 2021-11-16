extends KinematicBody2D

onready var player = get_parent().get_node("player")
onready var friend = $AnimatedSprite

var GRAVITY = 50
export var friend_speed = 100
var velocity = Vector2()
export var min_move_distance = 10

func _ready():
	set_physics_process(false)


func _physics_process(delta):
	var direction = (player.global_position - global_position).normalized()
	var distance_to_player = global_position.distance_to(player.global_position)
	friend.flip_h = direction.x < 0
	
	if distance_to_player >= min_move_distance:
		move_and_collide( direction * friend_speed * delta)
		velocity.y += GRAVITY


func _on_Area2D_body_entered(body):
	if "player" in body:
		set_physics_process(true)
	else:
		return
	

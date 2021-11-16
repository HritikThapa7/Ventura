extends KinematicBody2D
var is_inside_area = false
var treasure=false

signal treasure_found(true)
func _ready():
	pass 
func _process(delta):
	pass
	
		
	

func _on_Area2D_area_entered(area: Area2D)->void:
	is_inside_area=true
	treasure=true
	emit_signal("treasure_found",true)
	print("Treasure found")
	$Sprite.set_visible(false)
	$Timer.start()

func _on_Timer_timeout():
	queue_free()

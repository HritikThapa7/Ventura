extends Area2D

onready var Timer=$Timer


func _on_Illusion_body_entered(body):
	print("Body entered")
	$CollisionShape2D.set_deferred("disabled",true)
	Timer.start()
	

func _on_Timer_timeout():
	queue_free()
 
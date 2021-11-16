extends Bullet_xz
class_name Player_Bullet


func _on_PlayerBullet_body_entered(body: PhysicsBody2D) -> void:
	if body is Enemy:
		body.damage(damage)
	explode()

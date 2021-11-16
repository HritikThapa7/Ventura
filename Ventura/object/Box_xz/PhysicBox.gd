extends Box
class_name PhysicBox

var pushh

func _ready():
	pushh = AudioStreamPlayer2D.new()
	self.add_child(pushh)
	pushh.stream = load('res://Audio and sound effects/Voice023Music.wav')
	pushh.set_volume_db(20)

func push(velocity: Vector2)->void:
	pushh.play()
	move_and_slide(velocity)

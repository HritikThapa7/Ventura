extends Node2D

class_name RotatingGroupTrap

export var radius= Vector2.ONE*256
export var rotationalTime :=3.6
var platforms=[]
var orbitAngle=0
var prev_child_count=0
func _physics_process(delta):
	if prev_child_count!=get_child_count():
		prev_child_count=get_child_count()
	orbitAngle +=2 * PI*delta/float(rotationalTime)
	orbitAngle = wrapf(orbitAngle,-PI,PI)
	_update_platform()
	
func _update_platform():
	
	if platforms.size()!=0:
		var spacing =2*PI /float(platforms.size())
		for i in platforms.size():
			var new_position=Vector2()
			new_position.x=cos(spacing*i+orbitAngle)*radius.x
			new_position.y=cos(spacing*i+orbitAngle)*radius.y
			platforms[i].position=new_position
func _find_platform():
	platforms=[]
	for child in get_children():
		if child.is_in_group("platforms"):
			platforms.append(child)
 
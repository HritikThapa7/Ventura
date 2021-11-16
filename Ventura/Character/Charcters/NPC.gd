extends "res://Character/Charcters/Characters.gd"


onready var dialog = get_node("CanvasLayer/DialogBox")

var num
var tween_bool = false
var initial
var final
var ran
var naam

func _ready() -> void:
	naam = self.name
	initial = self.get_position()
#	if int(naam[-1]) % 2 == 0:
#		final = Vector2(initial.x + 500, initial.y)
#	else:
#		final = Vector2(initial.x, initial.y  + 500)
#		$Tween.interpolate_property(self, "position", initial, final, 2, Tween.TRANS_LINEAR,Tween.EASE_IN)
#	$Tween.start()

func _process(delta: float) -> void:
	randomize()
	var ran = rand_range(0,1)
	
	
func _dialogs():
	num = rand_range(0,5)
	global.is_talkable=false
	print(bool(global.is_talkable),"Character 1")
	dialog.set_visible(true)
	print("character 1")
	if global.is_present(global.event_collection, 'Event 3'):
		print("OKAYY...")
		dialog.get_node("Text").set_bbcode("Chaos")
		dialog.get_node("Text").set_visible_characters(0)
		print("character 1")
	else:
		print("Ishar zsdsadsa")
		dialog.get_node("Text").set_bbcode(dialog.NPC_dialog[num])
		dialog.get_node("Text").set_visible_characters(0)
	c= global.is_present(global.people_talked_collection,"NPC")
	if not c:
		global.people_talked_collection.append("NPC")


func _on_Area2D_body_entered(body):
	if body is Player:
		global.is_inside_area=true
		global.is_talkable=true
		print(global.is_talkable,"Area Entered")
		global.area_entered_name=str(self.name)
		print(global.area_entered_name)


func _on_Area2D_body_exited(body):
	if body is Player:
		global.is_inside_area = false
		global.is_talkable=false
		print(global.is_talkable," is talkable Area Exited")
		global.area_entered_name="No area entered"
		dialog.set_visible(false)


func _on_Timer_timeout():
	if tween_bool:
		$Tween.interpolate_property(self, "position", initial, final, 2, Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Tween.start()
	elif !tween_bool:
		$Tween.interpolate_property(self, "position", final, initial, 2, Tween.TRANS_LINEAR,Tween.EASE_IN)
		$Tween.start()
	tween_bool = !tween_bool

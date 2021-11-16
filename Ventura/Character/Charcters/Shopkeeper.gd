extends Character

onready var dialog: Panel = $CanvasLayer/DialogBox

func _ready() -> void:
	$AnimatedSprite.play("ideal")

func _process(delta: float) -> void:
	#_dialogs()
	pass
	
func _dialogs():
	global.is_talkable=false
	print(bool(global.is_talkable),"Character 2")
	dialog.set_visible(true)
	print("character 2")
	if global.is_present(global.event_collection,'Event_1'):
		dialog.get_node("Text").set_bbcode(dialog.dialog_character_2[dialogs_page["char_2"]["page"]])
		dialog.get_node("Text").set_visible_characters(0)
		dialogs_page["char_2"]["talked"] = true
		print("character 2")
		#opening_portal()
	else:
		print("OKAYY...")
		dialog.get_node("Text").set_bbcode(dialog.dialog_character_2[1])
		dialog.get_node("Text").set_visible_characters(0)
		print("character 2")
	c= global.is_present(global.people_talked_collection,'Character_2')
	if not c:
		global.people_talked_collection.append('Character_2')




func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area =true
		global.is_talkable=true
		print(global.is_talkable,"Area Entered")
		global.area_entered_name=str(self.name)
		print(global.area_entered_name)

func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area =false
		global.is_talkable=false
		print(global.is_talkable," is talkable Area Exited")
		print(global.is_talkable," is talkable Area Exited")
		global.area_entered_name="No area entered"
		dialog.set_visible(false)


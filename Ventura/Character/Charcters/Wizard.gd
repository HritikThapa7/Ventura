extends Character

onready var dialog: Panel = $CanvasLayer/DialogBox

func _ready() -> void:
	$AnimatedSprite.play("ideal")

func _process(delta: float) -> void:
	#_dialogs()
	pass
	
func _dialogs():
	global.is_talkable = false
	print(bool(global.is_talkable),"Character 4")
	dialog.set_visible(true)
		#if portal.used_portal:
		#	dialogs_page["char_4"]["page"] = 3
		#	dialog.get_node("Text").set_bbcode(dialog.dialog_character_4[3])
	if global.is_present(global.event_collection, "Event 3"):
		dialog.get_node("Text").set_bbcode(dialog.dialog_character_4[2])
		dialog.get_node("Text").set_visible_characters(0)
	elif dialogs_page["char_4"]["talked"] and dialogs_page["char_4"]["page"] < 1:
		dialogs_page["char_4"]["page"] += 1
		dialog.get_node("Text").set_bbcode(dialog.dialog_character_4[dialogs_page["char_4"]["page"]])
		dialog.get_node("Text").set_visible_characters(0)
		
	else:
		dialogs_page["char_4"]["talked"] = true
		dialog.get_node("Text").set_bbcode(dialog.dialog_character_4[dialogs_page["char_4"]["page"]])
		dialog.get_node("Text").set_visible_characters(0)
		global.event_collection.remove("Event_1")
		global.event_collection.append("Event_2")
		print(global.event_collection)
	print("Knight")
	c= global.is_present(global.people_talked_collection,'Knight')
	if not c:
		global.people_talked_collection.append('Knight')




func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area = true
		global.is_talkable= true
		print(global.is_talkable,"Area Entered")
		global.area_entered_name=str(self.name)
		print(global.area_entered_name)

func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area = false
		global.is_talkable = false
		print(global.is_talkable," is talkable Area Exited")
		dialog.set_visible(false)
		global.area_entered_name="No area entered"
		dialog.set_visible(false)



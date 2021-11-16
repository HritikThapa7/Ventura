extends Character

onready var dialog: Panel = $CanvasLayer/DialogBox

func _ready() -> void:
	$AnimatedSprite.play("ideal")

func _process(delta: float) -> void:
	#_dialogs()
	pass
	
func _dialogs():
	global.is_talkable = false
	print(bool(global.is_talkable),"Character 3")
	dialog.set_visible(true)
	dialog.get_node("Text").set_bbcode(dialog.dialog_character_3[dialogs_page["char_3"]["page"]])
	dialog.get_node("Text").set_visible_characters(0)
	dialogs_page["char_3"]["talked"] = true
	if dialogs_page["char_3"]["talked"] and dialogs_page["char_3"]["page"] < 1:
			dialogs_page["char_3"]["page"] += 1
			print("character 3")
	c= global.is_present(global.people_talked_collection,'Character_3')
	if not c:
		global.people_talked_collection.append('Character_3')




func _on_Area2D_body_entered(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area = true
		global.is_talkable=true
		print(global.is_talkable,"Area Entered")
		global.area_entered_name=str(self.name)
		print(global.area_entered_name)

func _on_Area2D_body_exited(body: PhysicsBody2D) -> void:
	if body is Player:
		global.is_inside_area = false
		global.is_talkable=false
		print(global.is_talkable," is talkable Area Exited")
		dialog.set_visible(false)
		global.area_entered_name="No area entered"
		dialog.set_visible(false)



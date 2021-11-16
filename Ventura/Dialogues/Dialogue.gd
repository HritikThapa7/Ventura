extends RichTextLabel

var dialog_character_1 = ["I heard there's a monster somewhere near this town. I'm very terrified."]
var dialog_character_2 = ["Bring me a shovel and I'll show you something." , "BRING IT FASTTT!" , "My father taught me how to dig this morning, come I'll show you."]
var page = 0

func _ready() -> void:
	set_bbcode(dialog_character_2[page])
	set_visible_characters(0)
	set_process_input(true)
	
func _input(event) -> void:
	if event.is_action_pressed("Z_button"):
		if get_visible_characters() > get_total_character_count():
			if page < dialog_character_2.size() - 1:
				page += 1
				set_bbcode(dialog_character_2[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())
			if page == dialog_character_2.size() - 1:
				get_parent().hide()

func _on_Timer_timeout() -> void:
	set_visible_characters(get_visible_characters() + 1)


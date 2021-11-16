extends Event_Characters
class_name Character

#onready var dialog: Panel = $DialogBox

var dialogs_page = {
	"char_1" : {"page" : 0, "talked" : false},
	"char_2" : {"page" : 0, "talked" : false},
	"char_3" : {"page" : 0, "talked" : false},
	"char_4" : {"page" : 0, "talked" : false},
	"char_5" : {"page" : 0, "talked" : false}
}
var c

func _dialogs() -> void:
	print("The function is not implemted by %s" %filename)
		


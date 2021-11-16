extends Panel

var dialog_character_1 = ["Wow!! Vilkas. You have woken up. Want to hear something new? There's a wizard in a town. He lives SOUTH to the town in the forest. It is said that hes knows everything","I see you have talked to the wizard. Hope you can find your mom's killer","Good to see you Vilkas"]
var dialog_character_2 = ["Noooooo!! All my items are wasted. It will take some time to manage all this stuff.","Good Morning sir. Have a good day."]
var dialog_character_3 = ["It is a nice day today."," I wish everyday was like this."]
var dialog_character_4 = ["Hello child!!! I am the greatest wizard this world has ever seen, who has answers to any questions. The mask you wear its something different like filled with magic. I want a precious item held in the cave ruins north to this town. Bring me this item and i will tell you what you want to know.","Bring me the item held in the cave ruins, north to the town and i will answer your question.", "You took long to come child, I could have stopped this disaster from happening if I had that item a little earlier. Anyways I can still end this chaos. Bring me an item deep in another cave located straight north from this town."]
var dialog_character_5 = ["You are not allowed to go through. Beyond here is very dangerous."]
var NPC_dialog = ["Hi! I am a musician. Would you like to listen to my guitar?... NO? It's okay I dont force people.", "I dont think this is where I was suppose to come.", "sssshhh. If you focus on your hearing you can listen to the noise of a waterfall.", "I came here to party. Let's rock !", "I like dogs. You're not a dog. Get out fo my sight.'"]
var magical_item = ["This must be what that wizard wants. My work has paid off."]
var xy_1 = ["Welcome to this mysterious magical world. Something in golden colour must be useful to you.","Your power is now  upgraded", "You found the key 1 to unlock the door no. 1","Door 1 is open.", "You found key 2.", "Door 2 is open.", "You found the treasure. Fire a bullet to unlock it.", "Hidden wall appeared.","This is magical Platform"]
var page = 0
var screensize


func _ready() -> void:
	screensize = get_viewport_rect()
	print(screensize)
	print(get_position())
	#set_position(Vector2(screensize.size.x/2, screensize.size.y + 320))
	#ss.x / 2 - 400,ss.y / 2 -250
	set_position(Vector2(600,900));
	print("Dialogue Box ",get_position())

func _on_Timer_timeout() -> void:
	$Text.set_visible_characters($Text.get_visible_characters() + 1)

func _on_Button_pressed() -> void:
	set_visible(false)
	
func _on_page_complete():
	var char_no = $Text.get_total_character_count()
	if($Text.get_visible_character() == char_no - 1):
		page += 1

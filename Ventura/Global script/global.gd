extends Node2D

var event_collection= ['Event_collection',"Event_1"]
var people_talked_collection= ['People_Collection']
var item_collected_collection=['Item_Collection']
var player_health
var is_talkable=false
var is_inside_area=false
var area_entered_name


func is_present(list_name, item_to_searched):
	for i in list_name:
		if i==item_to_searched:
			return true
			
func replace_element(list_name, initial_value, final_value):
	list_name.remove(initial_value)
	list_name.append(final_value)
	
func get_value(list_name):
	return list_name[0]

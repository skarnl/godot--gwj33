extends "res://entities/rooms/base_room.gd"


func set_configuration(room_config):
	.set_configuration(room_config)
	
	for d in doors_layer.get_children():
		d.self_modulate = Color(1, 1, 1, 0.6)

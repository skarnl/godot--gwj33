extends "res://entities/rooms/base_room.gd"


func _ready() -> void:
	self_modulate = Color(1, 1, 1, 0.4)
	
	print("preview room")


func set_configuration(room_config):
	# clear door
	_create_doors(room_config)

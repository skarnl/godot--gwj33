extends 'res://entities/rooms/base_room.gd'

# Overwrite to enforce only the bottom door
func _make_random_doors():
	return []

func _create_doors(_room_configuration):
	pass

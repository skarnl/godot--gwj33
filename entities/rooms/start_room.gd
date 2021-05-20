extends 'res://entities/rooms/base_room.gd'

# Overwrite to enforce only the bottom door
func _make_random_doors():
	return [BOTTOM]

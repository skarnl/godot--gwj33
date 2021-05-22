extends 'res://entities/rooms/base_room.gd'

# Overwrite to enforce only the bottom door
func _ready() -> void:
	set_configuration({
		"doors": [],
		"type": RoomTypes.EXIT
	})

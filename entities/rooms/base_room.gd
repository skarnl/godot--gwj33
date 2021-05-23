extends Node2D

var DoorInstance = preload('res://entities/door.tscn')

onready var doors_layer = $Doors
onready var type_icon = $TypeIcon

var room_configuration = {
	"doors": [],
	"type": RoomTypes.EMPTY	
}

var connections = {}

var is_visited = false

func _ready() -> void:
	randomize()
	

func _make_random_doors() -> Array:
	var doors = []
	var random_float = randf()
	
	var options = [DoorPositions.TOP, DoorPositions.RIGHT, DoorPositions.BOTTOM, DoorPositions.LEFT]
	options.shuffle()
	
	# add all
	for dir in options:
		doors.append(dir)
	
	# remove by chance
	if random_float < 0.9:
		doors.pop_back()
	
	if random_float < 0.7:
		doors.pop_back()

	if random_float < 0.3:
		doors.pop_back()	
	
	
	return doors


func _create_doors():
	# remove old doors
	for child in doors_layer.get_children():
		child.queue_free()
	
	for dir in room_configuration.doors:
		var door = DoorInstance.instance()
		door.direction = dir
		doors_layer.add_child(door)

func _visualize_type():
	match room_configuration.type:
		RoomTypes.ENEMY:
			type_icon.set_frame(6)
			pass
			
		RoomTypes.TREASURE:
			type_icon.set_frame(2)
			pass

		RoomTypes.BIG_TREASURE:
			type_icon.set_frame(0)
			pass
			
		RoomTypes.HEAL:
			type_icon.set_frame(4)
			pass
			
		_:
			type_icon.hide()
	

func visited():
	type_icon.hide()
	is_visited = true

func set_configuration(_room_configuration):
	room_configuration = _room_configuration
	_create_doors()
	_visualize_type()


func get_configuration():
	return room_configuration


func has_door_at_position(door_position) -> bool:
	return room_configuration.doors.has(door_position)

func add_connection(door_position, room) -> void:
	connections[door_position] = room
	
	_open_door(door_position)


func _open_door(door_position):
	var found_door = false
	
	for door in doors_layer.get_children():
		if door.direction == door_position:
			found_door = true
			door.open()

	if not found_door:
		var new_door = DoorInstance.instance()
		new_door.direction = door_position
		new_door.open()
		doors_layer.add_child(new_door)
	

func get_center_position() -> Vector2:
	return position + Vector2(8.0, 6.0)

extends Node2D

var DoorInstance = preload('res://entities/door.tscn')

onready var doors_layer = $Doors

enum { EMPTY, ENEMY, START, EXIT, TREASURE, KEY }

var room_configuration = {
	"doors": [],
	"type": EMPTY	
}

var connections = {}

func _ready() -> void:
	randomize()
	

func _make_random_doors() -> Array:
	var doors = []
	var random_float = randf()
	
	var options = [DoorPositions.TOP, DoorPositions.RIGHT, DoorPositions.BOTTOM, DoorPositions.LEFT]
	options.shuffle()
	
	if random_float > 0.95:
		doors.append(options.pop_front())
	
	if random_float > 0.9:
		doors.append(options.pop_front())
	
	if random_float > 0.8:
		doors.append(options.pop_front())
	
	doors.append(options.pop_front())
	
	return doors


func _create_doors():
	# remove old doors
	for child in doors_layer.get_children():
		child.queue_free()
	
	for dir in room_configuration.doors:
		var door = DoorInstance.instance()
		door.direction = dir
		doors_layer.add_child(door)


func set_configuration(_room_configuration):
	room_configuration = _room_configuration
	_create_doors()


func get_configuration():
	return room_configuration


func has_door_at_position(door_position) -> bool:
	
	print('has_door_at_position: ', door_position)
	print('doors: ', room_configuration.doors)
	print('has door: ', room_configuration.doors.has(door_position))
	
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
	return position + Vector2(8.0, 8.0)

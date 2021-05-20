extends Node2D

var DoorInstance = preload('res://entities/door.tscn')

onready var doors_layer = $Doors

enum { EMPTY, ENEMY, START, EXIT, TREASURE, KEY }

var room_configuration = {
	"doors": [],
	"type": EMPTY,
}

var rng

enum {TOP, RIGHT, BOTTOM, LEFT}

var options = [TOP, RIGHT, BOTTOM, LEFT]

func _ready() -> void:
	randomize()
	
	room_configuration.doors = _make_random_doors()
	_create_doors(room_configuration)

func _make_random_doors() -> Array:
	var doors = []
	var random_float = randf()
	options.shuffle()
	
	if random_float > 0.95:
		doors.append(options.pop_front())
	
	if random_float > 0.9:
		doors.append(options.pop_front())
	
	if random_float > 0.8:
		doors.append(options.pop_front())
	
	doors.append(options.pop_front())
	
	print(doors)
	
	return doors


func _create_doors(_room_configuration):
	print(_room_configuration)
	
	# remove old doors
	for child in doors_layer.get_children():
		child.queue_free()
	
	for dir in _room_configuration.doors:
		var door = DoorInstance.instance()
		door.direction = dir
		doors_layer.add_child(door)


func get_configuration():
	return room_configuration

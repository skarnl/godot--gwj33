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
	
	_make_random_doors()
	_create_doors()

func _make_random_doors() -> void:
	var random_float = randf()
	options.shuffle()
	
	if random_float > 0.95:
		room_configuration.doors.append(options.pop_front())
	
	if random_float > 0.9:
		room_configuration.doors.append(options.pop_front())
	
	if random_float > 0.8:
		room_configuration.doors.append(options.pop_front())
	
	room_configuration.doors.append(options.pop_front())


func _create_doors():
	for dir in room_configuration.doors:
		var door = DoorInstance.instance()
		door.direction = dir
		doors_layer.add_child(door)


func get_configuration():
	return room_configuration

extends Node2D

export (int) var columns = 6
export (int) var rows = 6

var DropZoneInstance = preload('res://entities/grid/dropzone.tscn')
var StartRoom = preload('res://entities/rooms/start_room.tscn')

var cell_size = 16.0

var zones = []

func _ready() -> void:
	_fill_grid()
	_add_start_room()

func _fill_grid() -> void:
	for c in columns:
		for r in rows:
			var d = DropZoneInstance.instance()
			d.position = Vector2(c * cell_size, r * cell_size)
			add_child(d)

func _add_start_room():
	var sr = StartRoom.instance()
	sr.position = Vector2(2 * cell_size, 0.0)
	add_child(sr)
	
#TODO: disable the dropzone dots around the start-room

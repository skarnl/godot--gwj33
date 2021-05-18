extends Node2D

export (int) var columns = 6
export (int) var rows = 6

onready var drop_zones = $DropZones

var DropZoneInstance = preload('res://entities/grid/dropzone.tscn')

var cell_size = 16.0

var zones = []

func _ready() -> void:
	_fill_grid()


func _fill_grid() -> void:
	for c in columns:
		for r in rows:
			var d = DropZoneInstance.instance()
			d.position = Vector2(c * cell_size, r * cell_size)
			drop_zones.add_child(d)

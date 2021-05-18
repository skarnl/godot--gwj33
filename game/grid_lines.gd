extends Node2D

var cell_size = 16.0
var cols = 6
var rows = 6
var grid_color = Color.gray

func _ready() -> void:
#	self_modulate = Color(1.0, 1.0, 1.0, 0.3)
	pass


func _draw() -> void:
	var points = []
	
	for c in cols:
		for r in rows:
			draw_primitive([Vector2(c * cell_size, r * cell_size)], [grid_color], [])

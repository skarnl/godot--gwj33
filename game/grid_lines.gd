extends Node2D

var cell_size = 16.0
var cols = 6
var rows = 6
var grid_color = Color.gray

func _draw() -> void:
	for c in cols + 1:
		draw_line(Vector2(0.0, c * cell_size), Vector2(rows * cell_size, c * cell_size), grid_color)
		
	for r in rows + 1:
		draw_line(Vector2(r * cell_size, 0.0), Vector2(r * cell_size, cols * cell_size), grid_color)

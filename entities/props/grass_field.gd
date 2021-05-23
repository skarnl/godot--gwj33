extends Node2D

var GrassInstance = preload('res://entities/props/grass.tscn')

export (int) var columns = 6

func _ready() -> void:
	for col in columns:
		var g = GrassInstance.instance()
		g.position = Vector2(col * 16.0, 0)
		add_child(g)
		

func set_start_field_position(col):
	print('set_start_field_position')
	print(col)
	
	get_child(col).hide()

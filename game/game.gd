extends Node2D


var screen_size = Vector2.ZERO


func _ready():
	# prevent from catching all mouse interaction
#	mouse_filter = MOUSE_FILTER_IGNORE
	
	screen_size = get_viewport().size
	print("game")

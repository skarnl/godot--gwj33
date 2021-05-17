extends Node2D


var screen_size = Vector2.ZERO


func _ready():
	screen_size = get_viewport().size
	print("game")

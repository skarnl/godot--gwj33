extends Node2D

var border_width = 2
var size = 24
var center_size = 20

func _ready() -> void:
	hide()

func _draw() -> void:
	draw_rect(Rect2(-4.0, -4.0, size, size), Color("ac3232"))
	draw_rect(Rect2(-2.0, -2.0, center_size, center_size), Color.black)

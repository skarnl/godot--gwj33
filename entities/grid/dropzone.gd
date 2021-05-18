extends Area2D

var hidden = false

func _draw() -> void:
	draw_rect(Rect2(0.0, 0.0, 16.0, 16.0), Color.black)
	
	if not hidden:
		draw_rect(Rect2(0.0, 0.0, 1.0, 1.0), Color.whitesmoke)

func hide_indicator() -> void:
	hidden = true
	
	update()

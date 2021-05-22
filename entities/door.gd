extends Node2D

enum {CLOSED, OPENED}

export (Color) var color = Color.yellow

var direction

var state = CLOSED 


func _draw() -> void:
	if state == CLOSED:
		_draw_closed()
	else:
		_draw_opened()


func _draw_closed():
	var width = 6.0
	var height = 2.0
	var ypos = 0.0
	var xpos = 5.0
	
	match(direction):
		DoorPositions.TOP: 
			draw_rect(Rect2(xpos, ypos, width, height), color)
		
		DoorPositions.RIGHT:
			draw_rect(Rect2(16.0 - ypos - height, xpos, height, width), color)
			
		DoorPositions.BOTTOM:
			draw_rect(Rect2(xpos, 16.0 - ypos - height, width, height), color)

		DoorPositions.LEFT:
			draw_rect(Rect2(ypos, xpos, height, width), color)

func _draw_opened():
	var closed_color = Color.black
	var width = 6.0
	var height = 2.0
	var ypos = 0.0
	var xpos = 5.0
	
	match(direction):
		DoorPositions.TOP: 
			draw_rect(Rect2(xpos, ypos, width, height), closed_color)
		
		DoorPositions.RIGHT:
			draw_rect(Rect2(16.0 - ypos - height, xpos, height, width), closed_color)
			
		DoorPositions.BOTTOM:
			draw_rect(Rect2(xpos, 16.0 - ypos - height, width, height), closed_color)

		DoorPositions.LEFT:
			draw_rect(Rect2(ypos, xpos, height, width), closed_color)

func open() -> void:
	state = OPENED
	
#	draw opened state
	update()

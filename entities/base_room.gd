extends Node2D

var doors = []
var rng

enum {TOP, RIGHT, BOTTOM, LEFT}

var options = [TOP, RIGHT, BOTTOM, LEFT]

func _ready() -> void:
	randomize()
	
	_make_random_doors()
	update()

func _make_random_doors() -> void:
	var random_float = randf()
	options.shuffle()
	
	if random_float > 0.95:
		doors.append(options.pop_front())
	
	if random_float > 0.9:
		doors.append(options.pop_front())
	
	if random_float > 0.8:
		doors.append(options.pop_front())
	
	doors.append(options.pop_front())

func _draw() -> void:
	draw_rect(Rect2(0.0, 0.0, 16.0, 16.0), Color.whitesmoke, false)
	
	for d in doors:
		_draw_door(d)

func _draw_door(dir) -> void:
	var color = Color.yellow
	var width = 6.0
	var height = 2.0
	var ypos = 0.0
	var xpos = 5.0
	
	match(dir):
		TOP: 
			draw_rect(Rect2(xpos, ypos, width, height), color)
		
		RIGHT:
			draw_rect(Rect2(16.0 - ypos - height, xpos, height, width), color)
			
		BOTTOM:
			draw_rect(Rect2(xpos, 16.0 - ypos - height, width, height), color)

		LEFT:
			draw_rect(Rect2(ypos, xpos, height, width), color)

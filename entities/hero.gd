extends Node2D

signal ask

export(float, 100, 1000, 10) var speed = 500

onready var timer = $Timer

var destination: Vector2

var STEP_SIZE = 2.0

func _ready() -> void:
	timer.wait_time = (1000 - speed) / 1000
	timer.connect('timeout', self, '_on_tick')
	destination = position


func _on_tick() -> void:
	if not _move():
		emit_signal('ask')
	
	
func _move() -> bool:
	var distance = position.distance_to(destination)
	
	if distance > 0.1:
		if position.x == destination.x:
			if position.y > destination.y:
				position.y -= STEP_SIZE
			else:
				position.y += STEP_SIZE
		else:
			if position.x > destination.x:
				position.x -= STEP_SIZE
			else:
				position.x += STEP_SIZE
		
		return true
	else:
		return false

# when the player died / was victorious
func stop_moving():
	timer.stop()

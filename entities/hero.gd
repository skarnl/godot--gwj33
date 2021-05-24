extends Node2D

signal ask

var destination: Vector2

var STEP_SIZE = 2.0

var time_passed = 0.0
var wait_time = 0.18

func _ready() -> void:
	destination = position


func _process(delta: float) -> void:
	time_passed += delta
	
	if time_passed >= wait_time:
		_on_tick()
		
		time_passed = 0

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
	set_process(false)

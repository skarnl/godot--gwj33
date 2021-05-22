extends "res://entities/rooms/base_room.gd"

signal mouse_over
signal mouse_out
signal selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ClickArea.connect('mouse_entered', self, '_on_mouse_over')
	$ClickArea.connect('mouse_exited', self, '_on_mouse_out')
	$ClickArea.connect('input_event', self, '_on_mouse_event')
	
	_make_a_room()


func _make_a_room():
	var doors = _make_random_doors()
	
	var room_types = [RoomTypes.EMPTY, RoomTypes.ENEMY, RoomTypes.TREASURE, RoomTypes.BIG_TREASURE]
	
	if doors.size() == 1:
		if randf() > 0.8:
			room_types.append(RoomTypes.BIG_TREASURE)
			
		room_types.append(RoomTypes.TREASURE)
		
	if doors.size() == 2:
		room_types.append(RoomTypes.TREASURE)
		room_types.append(RoomTypes.ENEMY)
		room_types.append(RoomTypes.HEAL)
		
	room_types.shuffle()
	
	set_configuration({
		"doors": doors,
		"type": room_types.pop_front()
	})


func _on_mouse_over() -> void:
	emit_signal('mouse_over')
	
	
func _on_mouse_out() -> void:
	emit_signal('mouse_out')


func _on_mouse_event(viewport, event, shape_idx) -> void:
	if (event is InputEventMouseButton && event.pressed):
		emit_signal('selected')

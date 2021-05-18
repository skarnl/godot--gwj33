extends "res://entities/rooms/base_room.gd"

signal mouse_over
signal mouse_out
signal selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ClickArea.connect('mouse_entered', self, '_on_mouse_over')
	$ClickArea.connect('mouse_exited', self, '_on_mouse_out')
	$ClickArea.connect('input_event', self, '_on_mouse_event')


func _on_mouse_over() -> void:
	emit_signal('mouse_over')
	
	
func _on_mouse_out() -> void:
	emit_signal('mouse_out')


func _on_mouse_event(viewport, event, shape_idx) -> void:
	if (event is InputEventMouseButton && event.pressed):
		emit_signal('selected')

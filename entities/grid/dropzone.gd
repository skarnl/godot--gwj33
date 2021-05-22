extends Area2D

signal mouse_clicked

var hidden = false
var disabled = false


func _ready() -> void:
	connect('input_event', self, '_on_mouse_event')
	
	
func _on_mouse_event(viewport, event, shape_idx) -> void:
	if (event is InputEventMouseButton && event.pressed):
		emit_signal('mouse_clicked')


# some logic to draw the grid 'dot'
func _draw() -> void:
	draw_rect(Rect2(0.0, 0.0, 16.0, 16.0), Color.black)
	
	if not hidden:
		draw_rect(Rect2(0.0, 0.0, 1.0, 1.0), Color.whitesmoke)

func hide_indicator() -> void:
	hidden = true
	
	update()


func disable() -> void:
	disabled = true
	
	$CollisionShape2D.disabled = true
	
	update()
	

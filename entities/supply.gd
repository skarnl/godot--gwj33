extends Node2D

const SupplyRoom := preload('res://entities/rooms/suppy_room.tscn')

signal selected(room_configuration)

const ROOM_WIDTH = 16.0
const SPACING = 10.0

onready var highlight = $Highlight

func _ready() -> void:
	_spawn_room(0)
	_spawn_room(1)
	_spawn_room(2)

func _calc_position_by_index(index: int) -> Vector2:
	return Vector2(index * ROOM_WIDTH + index * SPACING, 0.0)


func _spawn_room(index: int) -> void:
	var sr = SupplyRoom.instance()
	sr.position = _calc_position_by_index(index)
	sr.connect('mouse_over', self, '_on_room_mouse_over', [index])
	sr.connect('mouse_out', self, '_on_room_mouse_out')
	sr.connect('selected', self, '_on_room_selected', [index])
	add_child(sr)


func _on_room_mouse_over(index: int) -> void:
	highlight.position = _calc_position_by_index(index)
	highlight.show()


func _on_room_mouse_out() -> void:
	highlight.hide()
	

func _on_room_selected(index: int) -> void:
	print('room selected: ', index)

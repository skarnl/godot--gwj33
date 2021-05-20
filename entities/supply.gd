extends Node2D

const SupplyRoom := preload('res://entities/rooms/suppy_room.tscn')

signal selected(room_configuration)

const ROOM_WIDTH = 16.0
const SPACING = 10.0

onready var rooms = $Rooms
onready var highlight = $Highlight
onready var selected_highlight = $SelectedHighlight

var selected_index = -1

var rooms_list = []

func _ready() -> void:
	rooms_list.resize(3)
	
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
	rooms.add_child(sr)
	
	rooms_list[index] = sr


func _on_room_mouse_over(index: int) -> void:
	highlight.position = _calc_position_by_index(index)
	highlight.show()


func _on_room_mouse_out() -> void:
	highlight.hide()
	

func _on_room_selected(index: int) -> void:
	selected_index = index
	selected_highlight.position = _calc_position_by_index(selected_index)
	selected_highlight.show()
	
	var supply_room = rooms_list[index]
	var config = supply_room.get_configuration()
	
	emit_signal('selected', config)

func _on_selected_used() -> void:
	var used_room = rooms_list[selected_index]
	used_room.queue_free()
	
	_spawn_room(selected_index)
	
	selected_index = -1
	highlight.hide()
	selected_highlight.hide()

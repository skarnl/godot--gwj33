extends Node2D

signal selected_used

export (int) var columns = 6
export (int) var rows = 6

var DropZoneInstance = preload('res://entities/grid/dropzone.tscn')
var RoomInstance = preload('res://entities/rooms/room.tscn')
var StartRoom = preload('res://entities/rooms/start_room.tscn')
var PreviewRoom = preload('res://entities/rooms/preview_room.tscn')

var preview

var cell_size = 16.0

var zones = []

var selected_room_config

func _ready() -> void:
	_fill_grid()
	_add_start_room(1, 1)
	_add_preview_room()

func _fill_grid() -> void:
	for c in columns:
		zones.append([])
		
		for r in rows:
			var d = DropZoneInstance.instance()
			d.position = Vector2(c * cell_size, r * cell_size)
			d.connect('mouse_entered', self, '_on_mouse_entered', [c, r])
			d.connect('mouse_exited', self, '_on_mouse_exited', [c, r])
			d.connect('mouse_clicked', self, '_on_mouse_clicked', [c, r])
			add_child(d)
			
			# cols, rows
			zones[c].append(d)

func _add_preview_room():
	preview = PreviewRoom.instance()
	add_child(preview)
	
	print(preview.position)
	preview.hide()

func _on_mouse_entered(col, row) -> void:
	print('mouse over dropzone: ', col, row)
	
	if selected_room_config:
		preview.show()
		preview.set_configuration(selected_room_config)
		preview.position = Vector2(col * cell_size, row * cell_size)
	


func _on_mouse_exited(col, row) -> void:
#	start een timer, en hide dan de preview
#	preview.hide()
	pass


func _on_mouse_clicked(col, row) -> void:
	if selected_room_config:
		_add_room(selected_room_config, col, row)
		
		preview.hide()
		
		selected_room_config = null
		
		emit_signal('selected_used')

func _add_start_room(col, row):
	var sr = StartRoom.instance()
	sr.position = Vector2(col * cell_size, row * cell_size)
	add_child(sr)
	
	var start_zone = zones[col][row]
	start_zone.disable()
	
	#TODO: disable the dropzone dots around the start-room


func _add_room(room_config, col, row):
	var r = RoomInstance.instance()
	r.position = Vector2(col * cell_size, row * cell_size)
	add_child(r)
	
	r._create_doors(room_config)

	var zone = zones[col][row]
	zone.disable()

func set_selected_room_configuration(room_config):
	print('set selected room')
	
	selected_room_config = room_config
	
	
	
	
	
	
	

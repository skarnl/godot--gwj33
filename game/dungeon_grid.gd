extends Node2D

signal selected_used
signal finished

export (int) var columns = 6
export (int) var rows = 6

var DropZoneInstance = preload('res://entities/grid/dropzone.tscn')
var RoomInstance = preload('res://entities/rooms/room.tscn')
var StartRoom = preload('res://entities/rooms/start_room.tscn')
var EndRoom = preload('res://entities/rooms/end_room.tscn')
var PreviewRoom = preload('res://entities/rooms/preview_room.tscn')

var preview

var cell_size = 16.0

# dropzones
var zones = []

# rooms
var rooms = {}


var selected_room_config

var start_room
var end_room


# we store what movement our hero last made, so we know how to check what directions we first check
var last_movement_direction # RIGHT, DOWN, LEFT, UP

# {TOP, RIGHT, BOTTOM, LEFT}
enum MOVEMENT { UP, RIGHT, DOWN, LEFT }

var directions = {
	MOVEMENT.RIGHT: [DoorPositions.BOTTOM, DoorPositions.RIGHT, DoorPositions.TOP],
	MOVEMENT.DOWN: [DoorPositions.LEFT, DoorPositions.BOTTOM, DoorPositions.RIGHT],
	MOVEMENT.LEFT: [DoorPositions.TOP, DoorPositions.LEFT, DoorPositions.BOTTOM],
	MOVEMENT.UP: [DoorPositions.RIGHT, DoorPositions.TOP, DoorPositions.LEFT],
}


func _ready() -> void:
	_fill_grid()
	_add_start_room(1, 1) #make position random?
	_add_end_room(4, 4) #make position random?
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
	
	preview.hide()

func _on_mouse_entered(col, row) -> void:
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
	
	start_room = sr
	
	var zone = zones[col][row]
	zone.queue_free()
	
	_store_room_reference(col, row, sr)
	
	#TODO: disable the dropzone dots around the start-room


func _add_end_room(col, row):
	var er = EndRoom.instance()
	er.position = Vector2(col * cell_size, row * cell_size)
	add_child(er)
	
	end_room = er
	
	var zone = zones[col][row]
	zone.queue_free()
	
	_store_room_reference(col, row, er)
	
	#TODO: disable the dropzone dots around the start-room


func _add_room(room_config, col, row):
	var r = RoomInstance.instance()
	r.position = Vector2(col * cell_size, row * cell_size)
	add_child(r)
	
	r.set_configuration(room_config)

	var zone = zones[col][row]
	zone.queue_free()
	
	_store_room_reference(col, row, r)
	
	print('add room at: ', col, row)
	
	_store_connecting_rooms(col, row)
	
	
func _store_room_reference(col, row, room) -> void:
	rooms[_create_cell_id(col, row)] = room
	
	
func _create_cell_id(col, row) -> String:
	return "%d,%d" % [col, row]

func _get_room_for_cell(col, row):
	var cell_id = _create_cell_id(col, row)
	if rooms.has(cell_id):
		return rooms[cell_id]
	
	return null

# function to check for connecting rooms
# and store a reference in this room AND the connecting rooms
func _store_connecting_rooms(col, row):
	var current_room = _get_room_for_cell(col, row)
	
	if not current_room:
		return
		
	print("current_room doors: ", current_room.room_configuration.doors)
	
	# top
	if row > 0:
		var room = _get_room_for_cell(col, row - 1)
		
		if room and (current_room.has_door_at_position(DoorPositions.TOP) or room.has_door_at_position(DoorPositions.BOTTOM)):
			current_room.add_connection(DoorPositions.TOP, room)
			room.add_connection(DoorPositions.BOTTOM, current_room)
	
	# right
	if col < columns:
		var room = _get_room_for_cell(col + 1, row)
		
		if room and (current_room.has_door_at_position(DoorPositions.RIGHT) or room.has_door_at_position(DoorPositions.LEFT)):
			current_room.add_connection(DoorPositions.RIGHT, room)
			room.add_connection(DoorPositions.LEFT, current_room)
	
	# below
	if row < rows:
		var room = _get_room_for_cell(col, row + 1)
		
		if room and (current_room.has_door_at_position(DoorPositions.BOTTOM) or room.has_door_at_position(DoorPositions.TOP)):
			current_room.add_connection(DoorPositions.BOTTOM, room)
			room.add_connection(DoorPositions.TOP, current_room)
		
	# left
	if col > 0:
		var room = _get_room_for_cell(col - 1, row)
		
		if room and (current_room.has_door_at_position(DoorPositions.LEFT) or room.has_door_at_position(DoorPositions.RIGHT)):
			current_room.add_connection(DoorPositions.LEFT, room)
			room.add_connection(DoorPositions.RIGHT, current_room)

	
func set_selected_room_configuration(room_config):
	print('set selected room')
	
	selected_room_config = room_config
	
	
func get_next_destination(current_hero_position: Vector2):
	var current_hero_position_local = to_local(current_hero_position)
	
	if current_hero_position_local.distance_to(end_room.get_center_position()) < 0.1:
		print("##### FINISHEDDDD!!!! ")
		emit_signal('finished')
		return
	
	if is_in_dungeon(current_hero_position_local):
		print('we zitten IN de dungeon')
		
		var current_room = get_room_for_position(current_hero_position_local)		
		var connecting_rooms = current_room.connections
		
		if connecting_rooms.size() > 0:
			
			if connecting_rooms.size() == 1:
				var room = connecting_rooms.values().front()
				return to_global(room.get_center_position())
			
			var door_options = directions[last_movement_direction].duplicate()
			door_options.shuffle()
			
			# TODO prioritize unvisited rooms?
			
			for door_position in door_options:
				if connecting_rooms.has(door_position):
					last_movement_direction = door_position
					
					var room = connecting_rooms[door_position]
					return to_global(room.get_center_position())		
		
		return current_hero_position
	else:
		print("walk towards the start")
		
		# walk towards start_room
		var start_room_position = start_room.get_center_position()
		
		# walk horizontal
		if current_hero_position_local.x != start_room_position.x:
			last_movement_direction = MOVEMENT.RIGHT
			return to_global(Vector2(start_room_position.x, current_hero_position_local.y))
			
		# walk vertical
		else:
			last_movement_direction = MOVEMENT.DOWN
			return to_global(Vector2(current_hero_position_local.x, start_room_position.y))


func is_in_dungeon(local_position: Vector2) -> bool:
	return local_position.x > 0 \
	   and local_position.y > 0 \
	   and local_position.x < columns * cell_size \
	   and local_position.y < rows * cell_size
	

func get_room_for_position(local_position: Vector2):
	var col = int(local_position.x / cell_size)
	var row = int(local_position.y / cell_size)
	
	return _get_room_for_cell(col, row)

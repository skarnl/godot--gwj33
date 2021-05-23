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


# EMPTY, ENEMY, HEAL, TREASURE, BIG_TREASURE
var distr = {
	1: [10, 30, 30, 15, 15],
	2: [15, 30, 30, 15, 10],
	3: [20, 30, 20, 23, 7],
	4: [20, 30, 20, 25, 5]
}


func _make_a_room():
	var doors = _make_random_doors()
	var room_type
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	var chance = rng.randi_range(1, 100)
	
	var room_type_distribution = distr[doors.size()]
	
	var empty_treshold = room_type_distribution[0]
	var enemy_treshold = room_type_distribution[1] + empty_treshold
	var health_treshold = room_type_distribution[2] + enemy_treshold
	var treasure_treshold = room_type_distribution[3] + health_treshold
	# var big_treasure_treshold = room_type_distribution[4] + treasure_treshold
	# big treasure is just the left over
	
	if chance <= empty_treshold:
		room_type = RoomTypes.EMPTY
	elif chance > empty_treshold and chance <= enemy_treshold:
		room_type = RoomTypes.ENEMY
	elif chance > enemy_treshold and chance <= health_treshold:
		room_type = RoomTypes.HEAL
	elif chance > health_treshold and chance <= treasure_treshold:
		room_type = RoomTypes.TREASURE
	elif chance > treasure_treshold:
		room_type = RoomTypes.BIG_TREASURE
		
	set_configuration({
		"doors": doors,
		"type": room_type
	})


func _on_mouse_over() -> void:
	emit_signal('mouse_over')
	
	
func _on_mouse_out() -> void:
	emit_signal('mouse_out')


func _on_mouse_event(viewport, event, shape_idx) -> void:
	if (event is InputEventMouseButton && event.pressed):
		emit_signal('selected')

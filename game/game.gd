extends Node2D

onready var supply = $Supply
onready var grid = $DungeonGrid

func _ready():
	supply.connect('selected', self, '_on_room_selected')
	grid.connect('selected_used', supply, '_on_selected_used')


func _on_room_selected(room_configuration) -> void:
	grid.set_selected_room_configuration(room_configuration)

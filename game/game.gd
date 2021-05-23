extends Node2D

onready var supply = $Supply
onready var grid = $DungeonGrid
onready var hero = $Hero
onready var grass_field = $GrassField
onready var hud = $HUD

const STEP_SIZE = 16.0

var score = 0
var health = 3


func _ready():
	supply.connect('selected', self, '_on_room_selected')
	hero.connect('ask', self, '_on_hero_request_instructions')
	grid.connect('start_room_positioned', self, '_on_start_room_positioned')
	
	grid.connect('selected_used', supply, '_on_selected_used')
	
	grid.connect('defeat_enemy', self, '_on_defeat_enemy')
	grid.connect('heal', self, '_on_heal')
	grid.connect('pickup_treasure', self, '_on_pickup_treasure')
	grid.connect('pickup_big_treasure', self, '_on_pickup_big_treasure')


func _on_start_room_positioned(col):
	grass_field.set_start_field_position(col)

func _on_room_selected(room_configuration) -> void:
	grid.set_selected_room_configuration(room_configuration)


func _on_hero_request_instructions() -> void:
	print('hero requested instruction')
	
	var next_destination = grid.get_next_destination(hero.position)
	
	if next_destination:
		hero.destination = next_destination
	
	
func _on_defeat_enemy():
	hud.add_score(10)
	
	health -= 1
	temp_update()
	
func _on_heal():
	health += 1
	temp_update()
	
func _on_pickup_treasure():
	hud.add_score(3)
	temp_update()
	
func _on_pickup_big_treasure():
	hud.add_score(7)
	
	temp_update()
	
func temp_update():
	print('score  = ', score)
	print('health =', health)

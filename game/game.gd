extends Node2D

onready var supply = $Supply
onready var grid = $DungeonGrid
onready var hero = $Hero
onready var grass_field = $GrassField
onready var hud = $HUD

const STEP_SIZE = 16.0

const ENEMY_POINTS = 10
const TREASURE_POINTS = 3
const BIG_TREASURE_POINTS = 7
const STEP_COST = 1

const ENEMY_HEAL_COST = 2

const HEAL_REGAIN = 1

var player_died = false

var steps_taken = 0

func _ready():
	supply.connect('selected', self, '_on_room_selected')
	hero.connect('ask', self, '_on_hero_request_instructions')
	grid.connect('start_room_positioned', self, '_on_start_room_positioned')
	
	grid.connect('selected_used', supply, '_on_selected_used')
	
	grid.connect('defeat_enemy', self, '_on_defeat_enemy')
	grid.connect('heal', self, '_on_heal')
	grid.connect('pickup_treasure', self, '_on_pickup_treasure')
	grid.connect('pickup_big_treasure', self, '_on_pickup_big_treasure')
	
	grid.connect('finished', self, '_on_finished')


func _on_start_room_positioned(col):
	grass_field.set_start_field_position(col)

func _on_room_selected(room_configuration) -> void:
	grid.set_selected_room_configuration(room_configuration)


func _on_hero_request_instructions() -> void:
	if player_died:
		return
	
	var next_destination = grid.get_next_destination(hero.position)
	
	if next_destination:
		hero.destination = next_destination
		steps_taken += 1
		
		hud.add_score(STEP_COST * -1)
	
		
func _on_finished():
	print('VICTORY!')
	hero.stop_moving()
	
	print('player took: ' + str(steps_taken) + ' steps')
	
	# calculate score based on score * 10 - steps_taken
	
	var final_score = hud.score * 10 - steps_taken
	
	print('final score = ' + str(final_score))
	
func _on_defeat_enemy():
	if not hud.take_damage(ENEMY_HEAL_COST):
		print ('player died')
		player_died = true
		hero.stop_moving()
		
		print('player took: ' + str(steps_taken) + ' steps before they died')
	else:
		hud.add_score(ENEMY_POINTS)
	
	
func _on_heal():
	hud.heal(HEAL_REGAIN)
	
	
func _on_pickup_treasure():
	hud.add_score(TREASURE_POINTS)
	
	
func _on_pickup_big_treasure():
	hud.add_score(BIG_TREASURE_POINTS)
	
	

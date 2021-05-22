extends Node2D

onready var supply = $Supply
onready var grid = $DungeonGrid
onready var hero = $Hero

const STEP_SIZE = 16.0


func _ready():
	supply.connect('selected', self, '_on_room_selected')
	grid.connect('selected_used', supply, '_on_selected_used')
	hero.connect('ask', self, '_on_hero_request_instructions')


func _on_room_selected(room_configuration) -> void:
	grid.set_selected_room_configuration(room_configuration)


func _on_hero_request_instructions() -> void:
	print('hero requested instruction')
	
	hero.destination = grid.get_next_destination(hero.position)
	

	# vertaal hero positie naar grid positie
	# check dan bij de DungeonGrid welke deuren er zijn
	# bepaald dan de volgende lokatie ( = links, rechts, boven, beneden = de richting + cell_size = volgende lokatie )
	# animeer / tween dit
	# na de tween, begin op nieuw
	
	# vragen:
	# altijd eerst de linkerdeur, dan de benedendeur en dan de rechterdeur

# this script will hold the overall game state

extends Node


var Screens = {
	MAIN_MENU = 'res://screens/main_menu.tscn',
	GAME = 'res://game/game.tscn',
}

enum GameState {
	SPLASH,
	MAIN_MENU,
	GAME,
	PAUSED,
	GAME_OVER
}

var _current_state: int = GameState.SPLASH setget _set_current_state
var _previous_state: int


func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	
func start_game():
	transition_to(GameState.GAME)
	

# change the state to the next
func transition_to(new_state: int) -> void:
	match new_state:
		GameState.MAIN_MENU:
			_current_state = new_state
			SceneLoader.goto_scene(Screens.MAIN_MENU)
		
		GameState.GAME:
			if _current_state in {GameState.MAIN_MENU: true}:
				_current_state = new_state
				SceneLoader.goto_scene(Screens.GAME)
				

# pause handler
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			match _current_state:
				GameState.GAME:
					transition_to(GameState.PAUSED)
			
				GameState.PAUSED:
					transition_to(GameState.GAME)


func _set_current_state(new_state:int) -> void:
	_previous_state = _current_state
	_current_state = new_state

extends CanvasLayer

signal player_died

onready var heart1 = $Control/Lives/Heart1
onready var heart2 = $Control/Lives/Heart2
onready var heart3 = $Control/Lives/Heart3
onready var heart4 = $Control/Lives/Heart4
onready var heart5 = $Control/Lives/Heart5

onready var score_field = $Score

onready var you_died = $YouDied
onready var you_won = $YouWon

const MAX_LIVES = 5

var score:int = 0
var lives = 3

func _ready() -> void:
	_update_score(0)
	_update_lives()
	
	you_died.hide()
	you_won.hide()


func _update_score(_score):
	score = _score
	
	if score < 0:
		score = 0
		
	score_field.text = str(score)

func add_score(_score):
	_update_score(score + _score)


func heal(amount):
	lives += amount
	
	if lives > MAX_LIVES:
		lives = MAX_LIVES
	
	_update_lives()
	
func take_damage(amount):
	lives -= amount
	
	_update_lives()

	if lives <= 0:
		lives = 0
		
		# player died
		return false

	return true

func _update_lives():
	for i in range(1, 6):
		if lives > i - 1:
			self['heart' + str(i)].set_frame(0)
		else:
			self['heart' + str(i)].set_frame(1)

func show_died_message():
	you_died.show()


func show_you_won_message():
	you_won.show()

extends CanvasLayer


onready var score_field = $Score

var score:int = 0

func _ready() -> void:
	update_score(0)


func update_score(_score):
	score = _score
	
	if score < 0:
		score = 0
		
	score_field.text = str(score)

func add_score(_score):
	update_score(score + _score)

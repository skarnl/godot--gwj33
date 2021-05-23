extends Node2D

export var icon_frame = 0
export var show_minus = false

func _ready() -> void:
	$TypeIcon.set_frame(icon_frame)

	if show_minus:
		$plus.text = "-"

func set_count(c):
	$count.text = str(c) + "x"
	
func set_score(s):
	$score.text = str(s)

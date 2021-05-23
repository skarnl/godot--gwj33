extends Node2D

onready var top = $DirtTop
onready var right = $DirtRight
onready var left = $DirtLeft
onready var bottom = $DirtBottom

export var cols = 6
export var rows = 6

func _ready() -> void:
	right.position.x = cols * 16.0
	bottom.position.y = rows * 16.0

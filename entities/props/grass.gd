extends Sprite


func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	set_frame(rng.randi_range(0,8))

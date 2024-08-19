extends CanvasLayer

var speedValue : float
@onready var speed: Label = $Control/ColorRect/Speed

func _process(delta: float) -> void:
	speed.text = str(snapped(speedValue,1)) + " Km/h"

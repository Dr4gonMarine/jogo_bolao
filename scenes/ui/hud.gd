extends CanvasLayer

var speedValue : float
var sizeValue : float
@onready var speed: Label = $Control/Speed
@onready var size: Label = $Control/Size

func _process(delta: float) -> void:
	speed.text = "Speed: " + str(snapped(speedValue,0.1)) + " Km/h"
	size.text = "Size: " + str(snapped(sizeValue,0.001)) + " m"

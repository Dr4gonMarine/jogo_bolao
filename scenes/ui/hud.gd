extends CanvasLayer

var speedValue : float
var sizeValue : float
var timer_value : String
var show_restart : bool
@onready var speed: Label = $Control/Speed
@onready var size: Label = $Control/Size
@onready var restart: Label = $Control/restart
@onready var timer: Label = $Control/Timer

func _process(delta: float) -> void:
	speed.text = "Speed: " + str(snapped(speedValue,0.1)) + " Km/h"
	size.text = "Size: " + str(snapped(sizeValue,0.001)) + " m"
	timer.text = timer_value
	restart.visible = show_restart

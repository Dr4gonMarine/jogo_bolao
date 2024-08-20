extends Node

@onready var label_size: Label = $Control/GridContainer/LabelSize
@onready var label_time: Label = $Control/GridContainer/LabelTime
@onready var label_coin: Label = $Control/GridContainer/LabelCoin

var final_size : float = 0.0
var final_time : String = ""
var final_coin_count : String = ""

func _on_visibility_changed() -> void:
	label_size.text = "Size: " + str(snapped(final_size,0.001)) + " m"
	label_time.text = "Final Time: " + final_time
	label_coin.text = "final_coin_count"

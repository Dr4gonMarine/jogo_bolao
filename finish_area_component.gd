extends Node

@onready var label_size: Label = $Control/GridContainer/LabelSize
@onready var label_time: Label = $Control/GridContainer/LabelTime
@onready var label_coin: Label = $Control/GridContainer/LabelCoin

var final_size : float = 0.0
var final_time : String = ""
var final_coin_count : int = 0

func _on_body_entered(body: Node3D) -> void:
	if(body.is_in_group("ball")):
		#sei que n precisaria pegar a referencia da pagina pelo gameManager mas só quero dormir
		%GameManager.final_page.label_size.text = "Size: " + str(snapped(body.sphere_shape.radius,0.001)) + " m"
		%GameManager.final_page.label_time.text = "Final Time: " + %GameManager.time_string
		%GameManager.final_page.label_coin.text = "Coins: " + str(%GameManager.coin_count)
		%GameManager.final_page.visible = true
		get_tree().paused = true

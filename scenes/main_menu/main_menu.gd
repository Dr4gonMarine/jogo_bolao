extends Control

var button_type = null

func _on_play_pressed() -> void:
	$FadeAnimation.show()
	$FadeAnimation/fadeTimer.start()
	$FadeAnimation/AnimationPlayer.play("Fade_in")
	button_type = "start"


func _on_options_pressed() -> void:
	button_type = "options"
	$FadeAnimation.show()
	$FadeAnimation/fadeTimer.start()
	$FadeAnimation/AnimationPlayer.play("Fade_in")


func _on_quit_pressed() -> void:
	button_type = "quit"
	$FadeAnimation.show()
	get_tree().quit()


func _on_fade_timer_timeout():
	if button_type == "start":
		get_tree().change_scene_to_file("res://mapa01.tscn")
		print("Play pressed")
	elif button_type == "options":
		#get_tree().change_scene_to_file("res://mapa.tscn")
		print("Options pressed")
	elif button_type == "quit":
		get_tree().quit()
		print("Quit pressed")

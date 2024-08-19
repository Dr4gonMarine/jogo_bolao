extends CanvasLayer

var background_image_visible := true
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SoundEffects")
@onready var BGMUSIC_BUS_ID = AudioServer.get_bus_index("Background")

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(BGMUSIC_BUS_ID,linear_to_db(value))
	AudioServer.set_bus_mute(BGMUSIC_BUS_ID, value < .05)	


func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_visibility_changed() -> void:
	%BackgroundImage.visible = background_image_visible

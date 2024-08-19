extends Node

@onready var ui_menu: CanvasLayer = %UiMenu

func _ready() -> void:	
	ui_menu.visible = false
	ui_menu.background_image_visible = false
	var bgMusic = get_node("/root/BackGroundMusic")
	bgMusic._start_music()

func _finish_collision(body: Node3D) -> void:
	if(body.is_in_group("ball")):
		print("APUSDIOHFIUASDHNFOPIUHSADOIFUHSIOLDUFHOILSDUFOIUDFLIUSHNDILUFJSOLDIUFHIOLSHNDFLIUN")

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R:
			get_tree().reload_current_scene()
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().paused = !get_tree().paused
			ui_menu.visible = !ui_menu.visible

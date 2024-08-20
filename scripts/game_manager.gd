extends Node

@onready var ui_menu: CanvasLayer = %UiMenu
@onready var bola: RigidBody3D = %bola
@onready var hud: CanvasLayer = %Hud
@onready var final_page: CanvasLayer = %FinalPage

var time: float
var time_string : String
var coin_count := 0

func _ready() -> void:	
	ui_menu.visible = false
	ui_menu.background_image_visible = false
	final_page.visible = false	
	var bgMusic = get_node("/root/BackGroundMusic")
	bgMusic._start_music()

func _process(delta: float) -> void:
	hud.speedValue = bola.velocidade_atual
	hud.sizeValue = bola.sphere_shape.radius
	hud.show_restart = bola.show_restart
	
	time += delta
	var secs = fmod(time,60)
	var mins = fmod(time,60*60)/60
	
	time_string = "%02d : %02d" % [mins, secs]
	hud.timer_value = time_string

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_R:
			if(get_tree().paused):	
				get_tree().paused = !get_tree().paused
			get_tree().reload_current_scene()
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().paused = !get_tree().paused
			ui_menu.visible = !ui_menu.visible

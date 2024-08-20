extends Node

@onready var ui_menu: CanvasLayer = %UiMenu
@onready var bola: RigidBody3D = %bola
@onready var hud: CanvasLayer = %Hud
@onready var final_page: CanvasLayer = %FinalPage

var time: float
var time_string : String

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
			get_tree().reload_current_scene()
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().paused = !get_tree().paused
			ui_menu.visible = !ui_menu.visible


func _on_finish_area_component_body_entered(body: Node3D) -> void:
	if(body.is_in_group("ball")):
		final_page.visible = true
		final_page.final_size = bola.sphere_shape.radius
		final_page.final_time = time_string
		#final_coin_count : String
		get_tree().paused = true

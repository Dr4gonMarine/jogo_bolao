extends Node


func _ready() -> void:
	$FadeAnimation/AnimationPlayer.play("Fade_out")

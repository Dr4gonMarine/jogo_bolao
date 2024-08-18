extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var coin: Node3D = $"."

func _on_coin_entered(body: Node3D) -> void:
	if(body.is_in_group("ball")):		
		animation_player.play("pickup")
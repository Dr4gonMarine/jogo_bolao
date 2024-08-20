extends Node3D
#Spin in the y axis, right round.  

@export var rotation_speed = 0.01

func _physics_process(_delta):
	rotate_y(rotation_speed * _delta)

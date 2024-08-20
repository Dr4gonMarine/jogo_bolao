@tool
extends CharacterBody3D

@export var intCharToDisplay : int = 0
@export var fltAnimSpeed : float = 1.0

func _ready():
	#clear them all first
	for myNode in %GeneralSkeleton.get_children():
		myNode.hide()
		
	$Armature/GeneralSkeleton.get_child(intCharToDisplay).show()
	
	$AnimationPlayer.speed_scale = fltAnimSpeed
	
	
	


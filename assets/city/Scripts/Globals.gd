extends Node

signal sigRaining

var sceneType = "Main"	#track which current scene we're in.  Used to jump scenes rather than swap in below a node
var citySizeMultiplier = 1.0	#defaults for scaling skyscrapers

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func funcGetRandom(startVal,endVal):
	return randf_range(startVal,endVal)
	

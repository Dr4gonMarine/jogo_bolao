extends Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Rain.emitting = false
	pass # Replace with function body.


func _on_body_entered(body):
	if body.is_in_group("player"):	#if the player wanders into this area
		$Rain.emitting = true	#turn on the rain
		Globals.sigRaining.emit("entered")  #emit a signal that can be connected to that turns on light/rain/worldenvironment fx
		
	pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("player"):
		$Rain.emitting = false
		Globals.sigRaining.emit("exit")
	pass # Replace with function body.

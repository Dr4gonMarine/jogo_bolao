extends AudioStreamPlayer3D

# Lista de sons
@export var sons: Array[AudioStream] = []

func tocar_som_aleatorio() -> void:
	if sons.size() > 0:
		var som_aleatorio = sons[randi() % sons.size()]
		stream = som_aleatorio
		play()

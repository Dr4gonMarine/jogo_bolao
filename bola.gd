extends RigidBody3D

@export var SPEED = 20.0
@export var JUMP_VELOCITY = 5
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1

@onready var cameraRig = $CameraRig

func _ready() -> void:
	cameraRig.set_as_top_level(true)
	
func _physics_process(delta):
		var antigaPosicaoCamera = cameraRig.global_transform.origin
		var posicaoBola = global_transform.origin
		var novaPosicaoBola = lerp(antigaPosicaoCamera, posicaoBola, PORCENTAGEM_APROXIMACAO_CAMERA)
		cameraRig.global_transform.origin = novaPosicaoBola
		
		if Input.is_action_pressed("frente"):
			angular_velocity.x -= SPEED*delta
		elif Input.is_action_pressed("tras"):
			angular_velocity.x += SPEED*delta
		if Input.is_action_pressed("esquerda"):
			angular_velocity.z += SPEED*delta
		elif Input.is_action_pressed("direita"):
			angular_velocity.z -= SPEED*delta
			

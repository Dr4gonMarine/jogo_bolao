extends RigidBody3D

@export var VELOCIDADE = 20.0
@export var IMPULSO_PULO = 500
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1

@onready var cameraRig = $CameraRig
@onready var rayCastVerificaChao = $VerificaChao

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	cameraRig.set_as_top_level(true)
	rayCastVerificaChao.set_as_top_level(true)
	
func _physics_process(delta):
		#interpolação da movimentação da camera ao seguir a bola
		var antigaPosicaoCamera = cameraRig.global_transform.origin
		var posicaoBola = global_transform.origin
		var novaPosicaoBola = lerp(antigaPosicaoCamera, posicaoBola, PORCENTAGEM_APROXIMACAO_CAMERA)
		cameraRig.global_transform.origin = novaPosicaoBola
		
		#mantém raycast apontando pra baixo independente da rotação da bola
		rayCastVerificaChao.global_transform.origin = global_transform.origin
		
		if Input.is_action_pressed("frente"):
			angular_velocity.x -= VELOCIDADE*delta
		elif Input.is_action_pressed("tras"):
			angular_velocity.x += VELOCIDADE*delta
		if Input.is_action_pressed("esquerda"):
			angular_velocity.z += VELOCIDADE*delta
		elif Input.is_action_pressed("direita"):
			angular_velocity.z -= VELOCIDADE*delta
			
		var estaNoChao = rayCastVerificaChao.is_colliding()
		
		if Input.is_action_just_pressed("pular") and estaNoChao:
			apply_central_impulse(Vector3.UP*IMPULSO_PULO)
			#print("apertou espaço e estaNoChao = true")
			

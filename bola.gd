extends RigidBody3D

@export var VELOCIDADE = 20.0
@export var IMPULSO_PULO = 500
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1

@onready var cameraRig = $CameraRig
@onready var rayCastVerificaChao = $VerificaChao
@onready var bola: RigidBody3D = $"."

var estaNoChao:bool


func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
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
			
		estaNoChao = rayCastVerificaChao.is_colliding()
		
		if Input.is_action_just_pressed("pular") and estaNoChao:
			apply_central_impulse(Vector3.UP*IMPULSO_PULO)
			print("apertou espaço e estaNoChao = true")
	
		_gimmick()


func transformar_vector3_em_valor(v: Vector3) -> float:
	# Combina as componentes do Vector3 em um único valor
	var velocidade = v.length()
	# Normaliza a magnitude para o intervalo [0, 1]
	var normalized_magnitude = clamp(velocidade, 0.999, 0.111)
	# Mapeia o valor para o intervalo de 0.001 a 0.009	
	return 	normalized_magnitude


func _gimmick() -> void:
	if(bola.scale > Vector3(0.1, 0.1, 0.1) && estaNoChao && angular_velocity != Vector3.ZERO):					
		bola.scale *= 0.99
		

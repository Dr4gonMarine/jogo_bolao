extends RigidBody3D

@export var VELOCIDADE := 80.0
@export var IMPULSO_PULO := 500
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1
@export var fator_reducao: float = 0.01

@onready var cameraRig = $CameraRig
@onready var rayCastVerificaChao = $VerificaChao
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D

var estaNoChao: bool
var tamanho_inicial = 1.0
var porcentagem_reducao_maxima = 0.9

func _ready():
	cameraRig.set_as_top_level(true)
	rayCastVerificaChao.set_as_top_level(true)
	var sphere_shape = collision_shape.shape as SphereShape3D
	sphere_shape.radius = tamanho_inicial

func _physics_process(delta):
	var antigaPosicaoCamera = cameraRig.global_transform.origin
	var posicaoBola = global_transform.origin
	var novaPosicaoBola = lerp(antigaPosicaoCamera, posicaoBola, PORCENTAGEM_APROXIMACAO_CAMERA)
	cameraRig.global_transform.origin = novaPosicaoBola
	rayCastVerificaChao.global_transform.origin = global_transform.origin
	
	var move_direction := Vector3.ZERO	
	move_direction.x = Input.get_action_strength("tras") - Input.get_action_strength("frente")
	move_direction.z = Input.get_action_strength("esquerda") - Input.get_action_strength("direita")
	move_direction = move_direction.rotated(Vector3.UP,cameraRig.rotation.y).normalized()
	
	angular_velocity += move_direction * VELOCIDADE * delta	
	
	print(angular_velocity)

	estaNoChao = rayCastVerificaChao.is_colliding()

	if Input.is_action_just_pressed("pular") and estaNoChao:
		apply_central_impulse(Vector3.UP*IMPULSO_PULO)
		print("apertou espaço e estaNoChao = true")


	var velocidade_atual = linear_velocity.length()
	var sphere_shape = collision_shape.shape as SphereShape3D
	if velocidade_atual > 0 and sphere_shape.radius > tamanho_inicial * (1 - porcentagem_reducao_maxima):
		var reducao = velocidade_atual * fator_reducao * delta
		sphere_shape.radius -= reducao
		sphere_shape.radius = max(sphere_shape.radius, 0)
		mesh.scale = Vector3(sphere_shape.radius, sphere_shape.radius, sphere_shape.radius)
		print("---------------")
		print(sphere_shape.radius)

extends RigidBody3D

@export var VELOCIDADE := 20.0
@export var IMPULSO_PULO := 500
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1
@export var fator_reducao: float = 0.0001

@onready var cameraRig = $CameraRig
@onready var rayCastVerificaChao = $VerificaChao
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var hit_on_ground: AudioStreamPlayer3D = $HitOnGround
@onready var check_ground: CollisionShape3D = $CheckGround
@onready var camera_3d: Camera3D = %Camera3D

var estaNoChao: bool
var estavaNoChao: bool
var tamanho_inicial = 1.0
var porcentagem_reducao_maxima = 0.9
var sphere_shape : SphereShape3D

func _ready():
	cameraRig.set_as_top_level(true)
	rayCastVerificaChao.set_as_top_level(true)
	sphere_shape = collision_shape.shape as SphereShape3D
	sphere_shape.radius = tamanho_inicial
	rayCastVerificaChao.target_position.y = -tamanho_inicial

func _physics_process(delta):
	var antigaPosicaoCamera = cameraRig.global_transform.origin
	var posicaoBola = global_transform.origin
	var novaPosicaoBola = lerp(antigaPosicaoCamera, posicaoBola, PORCENTAGEM_APROXIMACAO_CAMERA)
	cameraRig.global_transform.origin = novaPosicaoBola
	rayCastVerificaChao.position = global_transform.origin
	
	var move_direction := Vector3.ZERO	
	move_direction.x = Input.get_action_strength("tras") - Input.get_action_strength("frente")
	move_direction.z = Input.get_action_strength("esquerda") - Input.get_action_strength("direita")
	move_direction = move_direction.rotated(Vector3.UP,cameraRig.rotation.y).normalized()
	
	#cameraRig.rotation.y += 
	angular_velocity += move_direction * VELOCIDADE * delta	

	estaNoChao = rayCastVerificaChao.is_colliding()
	
	if(!estavaNoChao and estaNoChao and !hit_on_ground.playing):
		hit_on_ground.pitch_scale += (1.0 - pow(sphere_shape.radius / tamanho_inicial,0.3))		
		hit_on_ground.play()
	estavaNoChao = estaNoChao

	if Input.is_action_just_pressed("pular") and estaNoChao:
		apply_central_impulse(Vector3.UP*IMPULSO_PULO)
		print("apertou espaço e estaNoChao = true")

	var velocidade_atual = linear_velocity.length()	
	_camera_juice(velocidade_atual)
	
	if velocidade_atual > 0 and sphere_shape.radius > tamanho_inicial * (1 - porcentagem_reducao_maxima) and estaNoChao:
		var reducao = velocidade_atual * fator_reducao * delta
		sphere_shape.radius -= reducao
		sphere_shape.radius = max(sphere_shape.radius, 0)
		mesh.scale = Vector3(sphere_shape.radius, sphere_shape.radius, sphere_shape.radius)
		print("---------------")
		print(sphere_shape.radius)
		

func _camera_juice(velocity : float) -> void:	
	if(velocity > 10 and camera_3d.fov < 110):
		camera_3d.fov += 0.1
	elif(velocity < 10 and camera_3d.fov > 75):
		camera_3d.fov -= 0.1

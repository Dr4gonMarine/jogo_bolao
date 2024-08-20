extends RigidBody3D

@export var IMPULSO_PULO := 500
@export var PORCENTAGEM_APROXIMACAO_CAMERA = 0.1
@export var velocidade := 15.0
@export var fator_reducao: float = 0.0001
@export var tamanho_inicial = 10.0
@export var fov_increment = 0.1

@onready var cameraRig = $CameraRig
@onready var rayCastVerificaChao = $VerificaChao
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var camera_3d: Camera3D = %Camera3D
@onready var bola: RigidBody3D = $"."
@onready var hit_on_something: AudioStreamPlayer3D = $HitOnSomething

var max_jumps := 2
var jump_count := 0
var velocidade_atual : float
var estaNoChao: bool
var porcentagem_reducao_maxima = 0.9
var sphere_shape : SphereShape3D

func _ready():
	cameraRig.set_as_top_level(true)
	rayCastVerificaChao.set_as_top_level(true)
	sphere_shape = collision_shape.shape as SphereShape3D
	sphere_shape.radius = tamanho_inicial
	rayCastVerificaChao.target_position.y = -tamanho_inicial
	set_contact_monitor(true)
	max_contacts_reported = 10  # Número de contatos que deseja monitorar

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
	
	
	angular_velocity += move_direction * velocidade * delta	

	estaNoChao = rayCastVerificaChao.is_colliding()

	if Input.is_action_just_pressed("pular") and jump_count < max_jumps:
		jump_count += 1
		match jump_count:
			0:
				apply_central_impulse(Vector3.UP*IMPULSO_PULO)
			1:
				apply_central_impulse(Vector3.UP*IMPULSO_PULO)
				apply_central_impulse(Vector3(-move_direction.z,0,move_direction.x)*IMPULSO_PULO)
			_:
				pass
	
	if(estaNoChao):
		jump_count= 0
	
	velocidade_atual = linear_velocity.length()	
	_camera_juice(velocidade_atual)
	_apply_gimmick(delta)
	

func _apply_gimmick(delta : float) -> void:
	if velocidade_atual > 0 and sphere_shape.radius > tamanho_inicial * (1 - porcentagem_reducao_maxima) and estaNoChao:
		var reducao = velocidade_atual * fator_reducao * delta
		sphere_shape.radius -= reducao
		sphere_shape.radius = max(sphere_shape.radius, 0)
		_reduce_mass(reducao)
		mesh.scale = Vector3(sphere_shape.radius, sphere_shape.radius, sphere_shape.radius)

func _reduce_mass(reduction : float) -> void:
	bola.mass -= reduction
	velocidade += reduction

func _camera_juice(velocity : float) -> void:	
	if(velocity > 10 and camera_3d.fov < 110):
		camera_3d.fov += fov_increment
	elif(velocity < 10 and camera_3d.fov > 75):
		camera_3d.fov -= fov_increment

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:	
	for i in range(state.get_contact_count()):		
		if(!hit_on_something.playing and !estaNoChao):
			hit_on_something.pitch_scale += (1.0 - pow(sphere_shape.radius / tamanho_inicial,0.3))		
			hit_on_something.tocar_som_aleatorio()
			break

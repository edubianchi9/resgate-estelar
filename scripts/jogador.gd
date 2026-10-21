extends CharacterBody2D
class_name Jogador

signal vidas_alteradas(vidas: int, maximo: int)
signal derrotado

## Velocidade inicial do personagem, em pixels por segundo.
@export var velocidade: float = 180.0
@export var vidas_maximas: int = 3
@export var intervalo_ataque: float = 0.55
@export var duracao_ataque: float = 0.12
@export var tempo_invulneravel: float = 0.8

var vidas: int
var direcao_olhando: Vector2 = Vector2.UP
var _recarga_ataque: float = 0.0
var _duracao_ataque_restante: float = 0.0
var _invulnerabilidade_restante: float = 0.0
var _ataque_ativo: bool = false

@onready var area_ataque: Area2D = $Ataque
@onready var alcance_ataque: CollisionShape2D = $Ataque/Alcance
@onready var efeito_ataque: Polygon2D = $Ataque/Efeito


func _ready() -> void:
	vidas = vidas_maximas
	vidas_alteradas.emit(vidas, vidas_maximas)


func _physics_process(delta: float) -> void:
	# Input.get_vector limita a magnitude a 1, então a diagonal não fica mais rápida.
	var direcao := Input.get_vector("left", "right", "up", "down")
	if direcao != Vector2.ZERO:
		if absf(direcao.x) > absf(direcao.y):
			direcao_olhando = Vector2.RIGHT if direcao.x > 0.0 else Vector2.LEFT
		else:
			direcao_olhando = Vector2.DOWN if direcao.y > 0.0 else Vector2.UP

	velocity = direcao * velocidade
	move_and_slide()

	_recarga_ataque = maxf(_recarga_ataque - delta, 0.0)
	_invulnerabilidade_restante = maxf(_invulnerabilidade_restante - delta, 0.0)
	if Input.is_action_just_pressed("attack") and _recarga_ataque == 0.0:
		_iniciar_ataque()
	if _ataque_ativo:
		_processar_ataque(delta)


func receber_dano(quantidade: int = 1) -> void:
	if _invulnerabilidade_restante > 0.0 or vidas <= 0:
		return
	vidas = maxi(vidas - quantidade, 0)
	vidas_alteradas.emit(vidas, vidas_maximas)
	if vidas == 0:
		derrotado.emit()
		return
	_invulnerabilidade_restante = tempo_invulneravel


func _iniciar_ataque() -> void:
	_recarga_ataque = intervalo_ataque
	_duracao_ataque_restante = duracao_ataque
	_ataque_ativo = true
	area_ataque.position = direcao_olhando * 20.0
	area_ataque.rotation = direcao_olhando.angle()
	alcance_ataque.set_deferred("disabled", false)
	area_ataque.set_deferred("monitoring", true)
	efeito_ataque.visible = true


func _processar_ataque(delta: float) -> void:
	for corpo in area_ataque.get_overlapping_bodies():
		if corpo.is_in_group("inimigos") and corpo.has_method("receber_golpe"):
			corpo.receber_golpe()
			_finalizar_ataque()
			return

	_duracao_ataque_restante -= delta
	if _duracao_ataque_restante <= 0.0:
		_finalizar_ataque()


func _finalizar_ataque() -> void:
	_ataque_ativo = false
	area_ataque.set_deferred("monitoring", false)
	alcance_ataque.set_deferred("disabled", true)
	efeito_ataque.visible = false

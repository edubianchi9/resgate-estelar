# Código desenvolvido com ajuda do ChatGPT.
extends CharacterBody2D
class_name Rato

signal alcancou_aliado(aliado: Node2D)

enum Estado { PERSEGUIR, CONTORNAR, ATACAR }

@export var velocidade: float = 52.0
@export var intervalo_dano: float = 0.85
@export var distancia_ataque: float = 12.0
@export var intervalo_recalculo_caminho: float = 0.25

var alvo: Node2D
var navegacao: NavegacaoArena
var _recarga_dano: float = 0.0
var _estado: Estado = Estado.PERSEGUIR
var _caminho: PackedVector2Array = PackedVector2Array()
var _indice_caminho: int = 0
var _tempo_recalculo_caminho: float = 0.0

@onready var area_deteccao: Area2D = $Deteccao
@onready var area_aliado: Area2D = $DeteccaoAliado


func _physics_process(delta: float) -> void:
	_recarga_dano = maxf(_recarga_dano - delta, 0.0)
	if not is_instance_valid(alvo):
		velocity = Vector2.ZERO
		move_and_slide()
		return

	if global_position.distance_to(alvo.global_position) <= distancia_ataque:
		_estado = Estado.ATACAR
	elif _linha_ate_alvo_bloqueada():
		_estado = Estado.CONTORNAR
	else:
		_estado = Estado.PERSEGUIR

	match _estado:
		Estado.PERSEGUIR:
			_caminho = PackedVector2Array()
			_indice_caminho = 0
			_tempo_recalculo_caminho = 0.0
			velocity = global_position.direction_to(alvo.global_position) * velocidade
		Estado.CONTORNAR:
			_seguir_caminho(delta)
		Estado.ATACAR:
			velocity = Vector2.ZERO
	move_and_slide()
	_processar_contato()
	_processar_aliado()


func configurar_navegacao(nova_navegacao: NavegacaoArena) -> void:
	navegacao = nova_navegacao


func receber_golpe() -> void:
	queue_free()


func _seguir_caminho(delta: float) -> void:
	if not is_instance_valid(navegacao):
		velocity = Vector2.ZERO
		return

	_tempo_recalculo_caminho -= delta
	if _tempo_recalculo_caminho <= 0.0:
		_caminho = navegacao.obter_caminho(global_position, alvo.global_position)
		_indice_caminho = 0
		_tempo_recalculo_caminho = intervalo_recalculo_caminho

	while _indice_caminho < _caminho.size():
		if global_position.distance_to(_caminho[_indice_caminho]) >= 9.0:
			break
		_indice_caminho += 1

	if _indice_caminho >= _caminho.size():
		velocity = Vector2.ZERO
		return
	velocity = global_position.direction_to(_caminho[_indice_caminho]) * velocidade


func _linha_ate_alvo_bloqueada() -> bool:
	var consulta := PhysicsRayQueryParameters2D.create(
		global_position,
		alvo.global_position,
		1,
		[get_rid()]
	)
	return not get_world_2d().direct_space_state.intersect_ray(consulta).is_empty()


func _processar_contato() -> void:
	for corpo in area_deteccao.get_overlapping_bodies():
		if corpo.is_in_group("jogador") and _recarga_dano == 0.0:
			if corpo.has_method("receber_dano"):
				corpo.receber_dano()
			_recarga_dano = intervalo_dano


func _processar_aliado() -> void:
	for corpo in area_aliado.get_overlapping_bodies():
		if corpo.is_in_group("aliados"):
			alcancou_aliado.emit(corpo)
			return

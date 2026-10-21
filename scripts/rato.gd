extends CharacterBody2D
class_name Rato

signal alcancou_aliado(aliado: Node2D)

@export var velocidade: float = 52.0
@export var intervalo_dano: float = 0.85

var alvo: Node2D
var _recarga_dano: float = 0.0

@onready var area_deteccao: Area2D = $Deteccao
@onready var area_aliado: Area2D = $DeteccaoAliado


func _physics_process(delta: float) -> void:
	_recarga_dano = maxf(_recarga_dano - delta, 0.0)
	if is_instance_valid(alvo):
		var distancia := global_position.distance_to(alvo.global_position)
		if distancia > 12.0:
			velocity = global_position.direction_to(alvo.global_position) * velocidade
		else:
			velocity = Vector2.ZERO
		move_and_slide()
	_processar_contato()
	_processar_aliado()


func receber_golpe() -> void:
	queue_free()


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

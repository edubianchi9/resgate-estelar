# Origem: código desenvolvido com assistência do ChatGPT.
extends CharacterBody2D
class_name Aliado

signal encontrado(aliado: Aliado)

@export var velocidade_seguir: float = 220.0
@export var distancia_seguir: float = 28.0

var alvo_seguir: Node2D
var esta_na_fila: bool = false

@onready var deteccao: Area2D = $Deteccao


func _ready() -> void:
	deteccao.body_entered.connect(_ao_tocar_personagem)


func _physics_process(delta: float) -> void:
	if not esta_na_fila or not is_instance_valid(alvo_seguir):
		return

	var distancia := global_position.distance_to(alvo_seguir.global_position)
	if distancia > distancia_seguir:
		var passos_necessarios := distancia - distancia_seguir
		var velocidade_atual := minf(velocidade_seguir, passos_necessarios / delta)
		velocity = global_position.direction_to(alvo_seguir.global_position) * velocidade_atual
	else:
		velocity = Vector2.ZERO
	move_and_slide()


func comecar_a_seguir(alvo: Node2D) -> void:
	esta_na_fila = true
	alvo_seguir = alvo
	collision_layer = 8
	add_to_group("aliados")
	deteccao.set_deferred("monitoring", false)


func _ao_tocar_personagem(corpo: Node2D) -> void:
	if not esta_na_fila and corpo.is_in_group("jogador"):
		encontrado.emit(self)

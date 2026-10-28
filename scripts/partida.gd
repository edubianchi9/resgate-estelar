# Código desenvolvido com ajuda do ChatGPT.
extends Node2D

@export var cena_rato: PackedScene = preload("res://entities/rato.tscn")
@export var cena_aliado: PackedScene = preload("res://entities/aliado.tscn")
@export var limite_ratos: int = 4

var _encerrada: bool = false
var _gerador_aleatorio := RandomNumberGenerator.new()
var _fila_aliados: Array[Aliado] = []

@onready var jogador: Jogador = $Arena/Jogador
@onready var vida: Label = $HUD/Vida
@onready var resgates: Label = $HUD/Resgates
@onready var mensagem_fim: Label = $HUD/Fim
@onready var gerador_ratos: Timer = $GeradorRatos


func _ready() -> void:
	_gerador_aleatorio.randomize()
	jogador.vidas_alteradas.connect(_atualizar_vida)
	jogador.derrotado.connect(_encerrar_por_vida)
	gerador_ratos.timeout.connect(_gerar_rato)
	_atualizar_vida(jogador.vidas, jogador.vidas_maximas)
	_atualizar_resgates()
	_criar_aliados()
	_gerar_rato(Vector2(88, 92))
	_gerar_rato(Vector2(1064, 556))
	gerador_ratos.start()


func _unhandled_input(event: InputEvent) -> void:
	if _encerrada and event.is_action_pressed("restart"):
		get_tree().reload_current_scene()


func _atualizar_vida(vidas: int, maximo: int) -> void:
	vida.text = "VIDA  %d/%d" % [vidas, maximo]


func _encerrar_por_vida() -> void:
	_encerrar("DERROTA\nA equipe ficou sem vida.\nEnter para reiniciar")


func _encerrar_por_aliado(_aliado: Node2D) -> void:
	_encerrar("DERROTA\nUm rato alcançou a equipe.\nEnter para reiniciar")


func _encerrar(mensagem: String) -> void:
	if _encerrada:
		return
	_encerrada = true
	gerador_ratos.stop()
	jogador.set_physics_process(false)
	for rato in get_tree().get_nodes_in_group("inimigos"):
		rato.set_physics_process(false)
	for aliado in get_tree().get_nodes_in_group("aliados"):
		aliado.set_physics_process(false)
	mensagem_fim.text = mensagem
	mensagem_fim.visible = true


func _gerar_rato(posicao: Vector2 = Vector2(-1, -1)) -> void:
	if _encerrada or get_tree().get_nodes_in_group("inimigos").size() >= limite_ratos:
		return
	if posicao.x < 0.0:
		posicao = _sortear_borda()
	var rato := cena_rato.instantiate() as Rato
	rato.alvo = jogador
	rato.configurar_navegacao($Arena/Navegacao as NavegacaoArena)
	rato.alcancou_aliado.connect(_encerrar_por_aliado)
	$Arena/Entidades.add_child(rato)
	rato.position = posicao


func _criar_aliados() -> void:
	var posicoes := [
		Vector2(190, 112),
		Vector2(960, 112),
		Vector2(190, 324),
		Vector2(960, 324),
		Vector2(576, 540),
	]
	for posicao in posicoes:
		var aliado := cena_aliado.instantiate() as Aliado
		aliado.encontrado.connect(_adicionar_a_fila)
		$Arena/Entidades.add_child(aliado)
		aliado.position = posicao


func _adicionar_a_fila(aliado: Aliado) -> void:
	if _encerrada or aliado.esta_na_fila:
		return

	var alvo: Node2D = jogador if _fila_aliados.is_empty() else _fila_aliados.back()
	aliado.comecar_a_seguir(alvo)
	_fila_aliados.append(aliado)
	_atualizar_resgates()
	if _fila_aliados.size() == 5:
		_encerrar("VITÓRIA\nOs cinco aliados foram resgatados!\nEnter para jogar de novo")


func _atualizar_resgates() -> void:
	resgates.text = "RESGATADOS  %d/5" % _fila_aliados.size()


func _sortear_borda() -> Vector2:
	match _gerador_aleatorio.randi_range(0, 3):
		0:
			return Vector2(62, _gerador_aleatorio.randf_range(64, 584))
		1:
			return Vector2(1090, _gerador_aleatorio.randf_range(64, 584))
		2:
			return Vector2(_gerador_aleatorio.randf_range(64, 1088), 62)
		_:
			return Vector2(_gerador_aleatorio.randf_range(64, 1088), 586)

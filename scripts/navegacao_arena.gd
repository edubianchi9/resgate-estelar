# Código desenvolvido com ajuda do ChatGPT.
extends Node2D
class_name NavegacaoArena

const TAMANHO_CELULA := Vector2(32.0, 32.0)
const REGIAO := Rect2i(2, 2, 32, 16)
const MARGEM_OBSTACULO := 12.0

var _grade := AStarGrid2D.new()


func _ready() -> void:
	_grade.region = REGIAO
	_grade.cell_size = TAMANHO_CELULA
	_grade.offset = TAMANHO_CELULA / 2.0
	_grade.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES
	_grade.default_compute_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	_grade.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
	_grade.update()
	_marcar_obstaculos()


func obter_caminho(origem: Vector2, destino: Vector2) -> PackedVector2Array:
	var celula_origem := _posicao_para_celula(origem)
	var inicio := _celula_livre_mais_proxima(celula_origem)
	var fim := _celula_livre_mais_proxima(_posicao_para_celula(destino))
	if inicio == Vector2i(-1, -1) or fim == Vector2i(-1, -1):
		return PackedVector2Array()

	var ids := _grade.get_id_path(inicio, fim)
	var caminho := PackedVector2Array()
	# Se voltar ao centro da célula atual a cada recálculo, o rato oscila.
	var primeira_etapa := 1 if inicio == celula_origem and ids.size() > 1 else 0
	for indice in range(primeira_etapa, ids.size()):
		caminho.append(_grade.get_point_position(ids[indice]))
	return caminho


func _marcar_obstaculos() -> void:
	for obstaculo in get_tree().get_nodes_in_group("obstaculos"):
		var colisao := obstaculo.get_node_or_null("Colisao") as CollisionShape2D
		if colisao == null:
			continue
		var forma := colisao.shape as RectangleShape2D
		if forma == null:
			continue

		var margem := forma.size * 0.5 + Vector2.ONE * MARGEM_OBSTACULO
		var minimo := _posicao_para_celula(colisao.global_position - margem)
		var maximo := _posicao_para_celula(colisao.global_position + margem - Vector2.ONE * 0.01)
		for x in range(minimo.x, maximo.x + 1):
			for y in range(minimo.y, maximo.y + 1):
				var id := Vector2i(x, y)
				if _grade.is_in_boundsv(id):
					_grade.set_point_solid(id)


func _celula_livre_mais_proxima(origem: Vector2i) -> Vector2i:
	var limite := maxi(REGIAO.size.x, REGIAO.size.y)
	for raio in range(limite):
		for x in range(origem.x - raio, origem.x + raio + 1):
			for y in range(origem.y - raio, origem.y + raio + 1):
				if absi(x - origem.x) + absi(y - origem.y) != raio:
					continue
				var id := Vector2i(x, y)
				if _grade.is_in_boundsv(id) and not _grade.is_point_solid(id):
					return id
	return Vector2i(-1, -1)


func _posicao_para_celula(posicao: Vector2) -> Vector2i:
	return Vector2i(floori(posicao.x / TAMANHO_CELULA.x), floori(posicao.y / TAMANHO_CELULA.y))

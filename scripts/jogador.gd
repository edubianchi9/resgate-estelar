extends CharacterBody2D

## Velocidade inicial do personagem, em pixels por segundo.
@export var velocidade: float = 180.0


func _physics_process(_delta: float) -> void:
	# Input.get_vector limita a magnitude a 1, então a diagonal não fica mais rápida.
	var direcao := Input.get_vector("left", "right", "up", "down")
	velocity = direcao * velocidade
	move_and_slide()

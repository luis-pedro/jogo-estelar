extends Node2D

var asteroide = preload("res://Players/asteroide.tscn")

@onready var life_counter: ProgressBar = $mostradores/container/life_container/life_counter

func _process(delta):
	life_counter.value = $"/root/Global".nVida * 20

#Criar os enemies

func _on_criar_asteroides_timeout() -> void:
	var alvo = asteroide.instantiate()
	add_child(alvo)

func _on_aumenta_velocidade_timeout() -> void:
	$"/root/Global".velAsteroide = $"/root/Global".velAsteroide + 25

#collisões do cenário
func _on_ground_area_entered(area: Area2D) -> void:
	$"/root/Global".nVida -= 1
	print($"/root/Global".nVida)

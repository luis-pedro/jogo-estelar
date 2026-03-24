extends Node2D

var asteroide = preload("res://Players/asteroide.tscn")

var current_round = 1 #Controla os rounds

@onready var life_counter: ProgressBar = $mostradores/container/life_container/life_counter

func _process(delta):
	life_counter.value = $"/root/Global".nVida * 20
	update_round()

#Criar os enemies

func _on_criar_asteroides_timeout() -> void:
	var alvo = asteroide.instantiate()
	add_child(alvo)

func _on_aumenta_velocidade_timeout() -> void:
	$"/root/Global".velAsteroide = $"/root/Global".velAsteroide + 25

#collisão do chão do cenário
func _on_ground_area_entered(area: Area2D) -> void:
	$"/root/Global".nVida -= 1
	print($"/root/Global".nVida)
	
#Função para controlar os rounds
func update_round():
	if $"/root/Global".pontos >= 60 and current_round != 4:
		start_round(4)
	elif $"/root/Global".pontos >= 30 and current_round != 3:
		start_round(3)
	elif $"/root/Global".pontos >= 15 and current_round != 2:
		start_round(2)
		
func start_round(round):
	current_round = round
	print("Round:", round)

	show_round_text(round)
	
func show_round_text(round):
	print("passou de round")

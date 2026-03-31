extends Node2D

var asteroide = preload("res://Players/asteroide.tscn")
var enemy01 = preload("res://Players/enemy_01.tscn")
var enemy02 = preload("res://Players/enemy_02.tscn")

var current_round = 1 #Controla os rounds

@onready var life_counter: ProgressBar = $mostradores/container/life_container/life_counter
@onready var bg_sound: AudioStreamPlayer = $bg_sound
@onready var criar_asteroides: Timer = $criarAsteroides
@onready var round_label: Label = $control/round_label

func _ready():
	set_process(false) # trava o jogo no começo
	await show_round_text(1)
	start_game()

func _process(delta):
	life_counter.value = $"/root/Global".nVida * 20
	update_round()

#Criar os enemies

#Asteroide
func _on_criar_asteroides_timeout() -> void:
	var alvo = asteroide.instantiate()
	add_child(alvo)

func _on_aumenta_velocidade_timeout() -> void:
	$"/root/Global".velAsteroide = $"/root/Global".velAsteroide + 25

#Enemy 01
func _on_criar_enemy_01_timeout() -> void:
	var alvo01 = enemy01.instantiate()
	add_child(alvo01)
	print("INIMIGO 1")
	
#Enemy02
func _on_criar_enemy_02_timeout() -> void:
	var alvo02 = enemy02.instantiate()
	add_child(alvo02)
	print("INIMIGO 2")
	
#Collisão do chão do cenário

func _on_ground_area_entered(area: Area2D) -> void:
	$"/root/Global".nVida -= 1
	print($"/root/Global".nVida)
	
#Função para controlar os rounds
func update_round():
	var pontos = Global.pontos
	
	if pontos >= 50 and current_round < 4:
		start_round(4)
		
	elif pontos >= 5 and current_round < 3:
		start_round(3)
		$criarEnemy02.start()
		
	elif pontos >= 2 and current_round < 2:
		start_round(2)
		$criarEnemy01.start()
		
func start_round(round):
	current_round = round
	print("Round:", round)

	show_round_text(round)
	
func show_round_text(round):
	round_label.text = "ROUND %d" % round
	round_label.visible = true
	
	# Começa invisível
	round_label.modulate.a = 0
	
	var tween = create_tween()
	
	# Fade IN (aparecer)
	tween.tween_property(round_label, "modulate:a", 1.0, 1.0)
	
	# Espera 1 segundo
	tween.tween_interval(1.0)
	
	# Fade OUT (sumir)
	tween.tween_property(round_label, "modulate:a", 0.0, 1.0)
	
	# Depois esconde
	tween.tween_callback(func(): round_label.visible = false)
	
func start_game():
	set_process(true)
	$bg_sound.play()
	$criarAsteroides.start()

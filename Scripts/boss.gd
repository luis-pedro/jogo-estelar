extends Area2D

var speed := 200
var direction := 1

var is_vulnerable := false
var can_take_damage := false

var blink_tween

@onready var anim: AnimatedSprite2D = $anim

func _ready():
	start_movement_cycle()

func _process(delta):
	if not is_vulnerable:
		move(delta)

#MOVIMENTO
func move(delta):
	position.x += direction * speed * delta
	
	# Detecta borda da tela
	if position.x <= 50:
		direction = 1
	elif position.x >= 1230:
		direction = -1

#CICLO DO BOSS
func start_movement_cycle():
	is_vulnerable = false
	can_take_damage = false
	
	await get_tree().create_timer(3.0).timeout
	
	enter_vulnerable_state()

#ENTRA NO ESTADO VULNERÁVEL
func enter_vulnerable_state():
	is_vulnerable = true
	can_take_damage = true
	
	blink_effect()
	
	#Fica vulnerável por um tempo
	await get_tree().create_timer(3.0).timeout
	
	#Se não tomou dano, volta ao normal
	if can_take_damage:
		exit_vulnerable_state()

#SAI DO ESTADO VULNERÁVEL
func exit_vulnerable_state():
	is_vulnerable = false
	can_take_damage = false
	
	# PARA o efeito de piscar
	if blink_tween:
		blink_tween.kill()
	
	anim.modulate = Color(1,1,1,1)
	
	start_movement_cycle()

#EFEITO DE PISCAR
func blink_effect():
	# Mata tween antigo (evita bug)
	if blink_tween:
		blink_tween.kill()
	
	blink_tween = create_tween()
	blink_tween.set_loops()
	
	blink_tween.tween_property(anim, "modulate:a", 0.2, 0.2)
	blink_tween.tween_property(anim, "modulate:a", 1.0, 0.2)

#DETECTA TIRO
func _on_area_entered(area: Area2D) -> void:
	if not area.is_in_group("bullet"):
		return
		
	if is_vulnerable and can_take_damage:
		take_damage()

#DANO
func take_damage():
	can_take_damage = false
	$"/root/Global".bVida -= 1
	
	print("Vida do boss:", $"/root/Global".bVida)
	
	if $"/root/Global".bVida <= 0:
		die()
		return
	
	exit_vulnerable_state()

#MORTE
func die():
	print("Boss morreu")
	queue_free()

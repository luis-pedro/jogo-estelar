extends Area2D

var largura = 1280

var bullet = preload("res://Players/bullet.tscn")

var velocidadeTiro = 1500
@onready var laser_sound: AudioStreamPlayer = $laser_sound

#Referênciação dos boosters
@onready var booster_idle_left: AnimatedSprite2D = $booster_idle_left
@onready var booster_idle_right: AnimatedSprite2D = $booster_idle_right

func _ready() -> void:
	self.global_position.x = largura / 2
	self.global_position.y = 690
	print(laser_sound  )

func _process(delta: float) -> void:
	$anim.animation = "idle"
	booster_idle_left.animation = "idle"
	booster_idle_right.animation = "idle"
	
	booster_idle_left.visible = true
	booster_idle_right.visible = true
	$booster_left_left.visible = false
	$booster_left_right.visible = false
	$booster_right_left.visible = false
	$booster_right_right.visible = false
	if (Input.is_action_pressed("setaEsquerda")) and (global_position.x > 64):
		move_local_x(delta * -600)
		$anim.animation = "esquerda"
		$booster_left_left.animation = "left"
		$booster_left_right.animation = "left"
		
		$booster_left_left.visible = true
		$booster_left_right.visible = true
		booster_idle_left.visible = false
		booster_idle_right.visible = false
		$booster_right_left.visible = false
		$booster_right_right.visible = false
	if (Input.is_action_pressed("setaDireita")) and (global_position.x < 1216):
		move_local_x(delta * 600)
		$anim.animation = "direita"
		$booster_right_left.animation = "right"
		$booster_right_right.animation = "right"
		
		$booster_left_left.visible = false
		$booster_left_right.visible = false
		booster_idle_left.visible = false
		booster_idle_right.visible = false
		$booster_right_left.visible = true
		$booster_right_right.visible = true
	if (Input.is_action_just_pressed("space")):
		_atirar()
	
func _atirar():
	var tiro = bullet.instantiate()
	tiro.global_position = Vector2(global_position.x, global_position.y - 35)
	get_tree().current_scene.add_child(tiro)
	laser_sound.play()

func _on_area_entered(area: Area2D) -> void: #Quando o asteroide colide com a navee
	$"/root/Global".nVida -= 1

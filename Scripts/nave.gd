extends Area2D

var largura = 1280
var bullet = preload("res://Players/bullet.tscn")
var velocidadeTiro = 1500
@onready var laser_sound: AudioStreamPlayer = $laser_sound

func _ready() -> void:
	self.global_position.x = largura / 2
	self.global_position.y = 690
	print(laser_sound  )

func _process(delta: float) -> void:
	$anim.animation = "idle"
	if (Input.is_action_pressed("setaEsquerda")) and (global_position.x > 64):
		move_local_x(delta * -600)
		$anim.animation = "esquerda"
	if (Input.is_action_pressed("setaDireita")) and (global_position.x < 1216):
		move_local_x(delta * 600)
		$anim.animation = "direita"
	if (Input.is_action_just_pressed("space")):
		_atirar()
	
func _atirar():
	var tiro = bullet.instantiate()
	tiro.global_position = Vector2(global_position.x, global_position.y - 35)
	get_tree().current_scene.add_child(tiro)
	laser_sound.play()

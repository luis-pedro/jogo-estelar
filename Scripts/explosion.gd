extends Area2D

@onready var anim: AnimatedSprite2D = $anim
@onready var explosao: AudioStreamPlayer = $explosao

func _ready():
	anim.play("explode")
	$explosao.play()


func _on_anim_animation_finished() -> void:
	queue_free()

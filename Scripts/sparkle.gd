extends Area2D

@onready var anim: AnimatedSprite2D = $anim

func _ready():
	anim.play("idle")

func _on_anim_animation_finished() -> void:
	queue_free()

extends Area2D

@onready var sound: Timer = $sound
@onready var explosao: AudioStreamPlayer = $explosao

func _ready():
	randomize()
	self.global_position.x = randi_range(50, 1250)
	self.global_position.y = -40

func _process(delta):
	move_local_y(delta * $"/root/Global".velAsteroide)

func _on_area_entered(area: Area2D) -> void:
	$explosao.play()
	$sound.start()
	$"/root/Global".pontos = $"/root/Global".pontos + 1

func _on_sound_timeout() -> void:
	queue_free()

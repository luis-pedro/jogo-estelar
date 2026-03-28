extends Area2D

var explosion_scene = preload("res://Players/explosion.tscn")

@onready var sound: Timer = $sound
@onready var explosao: AudioStreamPlayer = $explosao

func _ready():
	randomize()
	self.global_position.x = randi_range(50, 1250)
	self.global_position.y = -40

func _process(delta):
	move_local_y(delta * $"/root/Global".velAsteroide)

func _on_area_entered(area: Area2D) -> void: #quando o bullet entra em contato
	if area.is_in_group("bullet"):
		$"/root/Global".pontos = $"/root/Global".pontos + 1
		destruir()
		
func destruir():
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_tree().current_scene.add_child(explosion)
	
	queue_free()

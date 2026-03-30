extends Area2D

func _ready() -> void:
	randomize()
	self.global_position.x = randi_range(50, 1250)
	self.global_position.y = -40

func _process(delta: float) -> void:
	move_local_y(delta * $"/root/Global".velEnemy01)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		
		$"/root/Global".pontos = $"/root/Global".pontos + 1
		
		#aqui é a função destruir do asteroide
		queue_free() #apagar isso e revisar a função

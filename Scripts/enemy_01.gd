extends Area2D

var sparkle_scene = preload("res://Players/sparkle.tscn")

func _ready() -> void:
	randomize()
	self.global_position.x = randi_range(50, 1250)
	self.global_position.y = -40

func _process(delta: float) -> void:
	move_local_y(delta * $"/root/Global".velEnemy01)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		
		$"/root/Global".pontos = $"/root/Global".pontos + 1
		destruir()
		
func destruir():
	var sparkle = sparkle_scene.instantiate()
	sparkle.global_position = global_position
	get_tree().current_scene.add_child(sparkle)
	
	queue_free()

extends Area2D

var speed := randi_range(350, 550)

func _process(delta):
	position.y += speed * delta
	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("collision"):
		queue_free()
	if area.is_in_group("nave"):
		queue_free()

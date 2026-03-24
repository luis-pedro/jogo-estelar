extends Area2D

@export var speed = 1500

func _process(delta):
	position.y -= speed * delta
	
	if position.y < -50:
		queue_free()
		
	#if(is_in_group(dano)):
		#pass

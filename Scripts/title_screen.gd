extends Control

func _ready() -> void:
	$"/root/Global".nVida = 5
	$"/root/Global".bVida = 10
	$"/root/Global".pontos = 0
	$"/root/Global".velAsteroide = 100

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

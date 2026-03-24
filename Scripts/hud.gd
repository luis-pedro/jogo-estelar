extends Control

@onready var life_icon: TextureRect = $container/life_container/life_icon
@onready var life_counter: ProgressBar = $container/life_container/life_counter
@onready var point_label: Label = $container/point_container/point_label
@onready var point_counter: Label = $container/point_container/point_counter

func _ready() -> void:
	point_counter.text = str("%04d" % $"/root/Global".pontos)

func _process(delta: float) -> void:
	point_counter.text = str("%04d" % $"/root/Global".pontos)

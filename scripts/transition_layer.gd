extends Node2D

signal transition_done
signal midpoint_reached

@onready var anim_layer = $AnimationPlayer

func _ready() -> void:
	
	SignalBus.start_cutscene.connect(_on_start_cutscene)

func _on_start_cutscene() -> void:
	anim_layer.play("fade in & out")
	
	
	await get_tree().create_timer(0.5).timeout
	midpoint_reached.emit()
	
	await anim_layer.animation_finished
	transition_done.emit()

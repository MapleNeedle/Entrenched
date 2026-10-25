extends Area2D

var has_triggered: bool = false
@onready var transition_layer = $"../TransitionLayer"

func _ready() -> void:
	if transition_layer and transition_layer.has_signal("midpoint_reached"):
		transition_layer.midpoint_reached.connect(_on_animation_midpoint_reached)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_Character" and not has_triggered:
		has_triggered = true
		body.is_talking = true
		
		Dialogic.start("MainTimeline", "T1: Fix Trench2")
		
		await Dialogic.timeline_ended
		
		SignalBus.start_cutscene.emit()
		
		await transition_layer.transition_done
		
		body.is_talking = false

func _on_animation_midpoint_reached() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.global_position = Vector2(-60.0, 367.0)

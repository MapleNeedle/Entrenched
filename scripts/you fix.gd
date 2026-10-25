extends Area2D

var has_triggered: bool = false
@onready var transition_layer = $"../TransitionLayer"
var target_scene: String = "res://Day 2 Evening.tscn"

func _ready() -> void:
	if transition_layer and transition_layer.has_signal("midpoint_reached"):
		transition_layer.midpoint_reached.connect(_on_animation_midpoint_reached)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_Character" and not has_triggered:
		has_triggered = true
		body.is_talking = true
		
		Dialogic.start("MainTimeline", "TT1")
		
		await Dialogic.timeline_ended
		
		SignalBus.start_cutscene.emit()
		
		await transition_layer.transition_done
		
		body.is_talking = false
		
		SignalBus.player_not_done = false

func _on_animation_midpoint_reached() -> void:
	
	if target_scene != "":
			get_tree().call_deferred("change_scene_to_file", target_scene)

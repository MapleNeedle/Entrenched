extends Area2D

var has_triggered: bool = false
@onready var transition_layer = $"../TransitionLayer"

func _ready() -> void:
	if transition_layer and transition_layer.has_signal("midpoint_reached"):
		transition_layer.midpoint_reached.connect(_on_animation_midpoint_reached)


func _on_body_entered(body):
	
	if body.name == "Main_Character" and not has_triggered:
		has_triggered = true
		
		body.is_talking = true
		
		SignalBus.start_cutscene.emit()
		
		await transition_layer.transition_done
		
		Dialogic.start("MainTimeline", "3.1A1")
		
		
		
func _on_animation_midpoint_reached() -> void:
	
	SignalBus.show_bodies.emit()

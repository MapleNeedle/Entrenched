extends Area2D

var has_triggered: bool = false
@onready var transition_layer = $TransitionLayer
signal start_cutscene


func _on_body_entered(body):
	
	if body.name == "DugoutMainCharacters2" and not has_triggered:
		has_triggered = true
		
		body.is_talking = true
		
		SignalBus.start_cutscene.emit()
		
		await transition_layer.transition_done
		
		Dialogic.start("MainTimeline", "A1.3: Dugout Morning/Stand To and Inspection")
		
		Dialogic.timeline_ended.connect(func(): 
			if is_instance_valid(body) and "is_talking" in body:
				body.is_talking = false
		, CONNECT_ONE_SHOT)

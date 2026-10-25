extends Area2D

var has_triggered: bool = false


func _on_body_entered(body):
	
	if body.name == "Main_Character" and not has_triggered and SignalBus.player_not_done:
		has_triggered = true
		
		
		body.is_talking = true
		
		await get_tree().create_timer(0.5).timeout
		
		Dialogic.start("MainTimeline", "A1: Day 2 Evening")
		
		Dialogic.timeline_ended.connect(func(): 
			if is_instance_valid(body) and "is_talking" in body:
				body.is_talking = false
		, CONNECT_ONE_SHOT)

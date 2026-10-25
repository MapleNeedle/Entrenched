extends Area2D

var has_triggered: bool = false


func _on_body_entered(body):
	
	if body.name == "Main_Character" and not has_triggered:
		has_triggered = true
		
		body.is_talking = true
		
		Dialogic.start("MainTimeline", "D1 Look into No Man’s Land")
		
		Dialogic.timeline_ended.connect(func(): 
			if is_instance_valid(body) and "is_talking" in body:
				body.is_talking = false
		, CONNECT_ONE_SHOT)

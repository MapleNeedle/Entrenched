extends Area2D

func _on_body_entered(body):
	
	if body.name == "Main_Character":
		
		
		body.is_talking = true
		
		Dialogic.start("MainTimeline", "3.1B")
		
		Dialogic.timeline_ended.connect(func(): 
			if is_instance_valid(body) and "is_talking" in body:
				body.is_talking = false
		, CONNECT_ONE_SHOT)

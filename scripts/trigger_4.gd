extends Area2D

func _on_body_entered(body):
	
	if body.name == ("Main_Character"):
		
		body.is_talking = true
		Dialogic.start("start1", "Box4")
		Dialogic.timeline_ended.connect(func(): 
			if is_instance_valid(body): 
				body.is_talking = false
		, CONNECT_ONE_SHOT)
		
		

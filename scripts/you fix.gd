extends Area2D

var has_triggered: bool = false



func _on_body_entered(body: Node2D) -> void:
	if body.name == "Main_Character" and not has_triggered:
		has_triggered = true
		body.is_talking = true
		
		Dialogic.start("MainTimeline", "TT1")
		

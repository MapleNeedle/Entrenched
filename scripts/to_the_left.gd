extends Area2D

var has_triggered: bool = false

var target_scene: String = "res://Left.tscn"

func _on_body_entered(body):
	
	if body.name == "Main_Character":
		
		Dialogic.VAR.chosen_path = "Go to the left"
		
		has_triggered = true
		
		if target_scene != "":
			get_tree().call_deferred("change_scene_to_file", target_scene)

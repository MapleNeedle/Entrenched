extends Area2D

var has_triggered: bool = false

var target_scene: String = "res://A3; Go on Senty Duity.tscn"

func _on_body_entered(body):
	
	if body.name == "Main_Character":
		
		has_triggered = true
		
		if target_scene != "":
			get_tree().call_deferred("change_scene_to_file", target_scene)

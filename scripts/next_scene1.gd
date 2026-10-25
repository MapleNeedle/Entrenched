extends Area2D

var target_scene: String = "res://A1_start.tscn"

func _on_body_entered(body):
	
	if body.name == "Main_Character":
		if target_scene != "":
			get_tree().call_deferred("change_scene_to_file", target_scene)

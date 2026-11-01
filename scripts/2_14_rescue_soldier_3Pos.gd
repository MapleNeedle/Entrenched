extends Node2D

func _ready() -> void:
	
	if SignalBus.second_scene_visit_count >= 0:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			
			player.global_position = Vector2(-44.0, -333.0)

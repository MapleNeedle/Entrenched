extends AnimatedSprite2D

func _ready():

	play("start screen")


func _on_start_button_start_game_requesed():
	get_tree().change_scene_to_file("res://start_walk_up.tscn")

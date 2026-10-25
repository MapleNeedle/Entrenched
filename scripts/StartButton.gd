extends TextureButton

signal start_game_requesed

func _on_pressed():
	
	emit_signal("start_game_requesed")

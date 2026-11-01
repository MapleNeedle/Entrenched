extends StaticBody2D

@onready var anim_player = $AnimationPlayer

func _ready():
	
	anim_player.play("cpl barron idle")
	
	SignalBus.show_bodies.connect(_show_body)
	
	visible = false

func _show_body():
	if Dialogic.VAR.chosen_path == "3.1AMM1":
		visible = true

extends StaticBody2D

@onready var anim_player = $AnimationPlayer

func _ready():
	
	anim_player.play("asian npc up down")
	
	SignalBus.show_bodies.connect(_show_body)
	
	visible = false
	
func _show_body():
	if Dialogic.VAR.chosen_path == "2.8 Assist Solider":
		visible = true

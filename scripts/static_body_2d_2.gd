extends StaticBody2D

@onready var anim_player = $AnimationPlayer

func _ready():
	
	anim_player.play("cpl barron idle")
	

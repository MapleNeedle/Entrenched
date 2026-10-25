extends CharacterBody2D

const SPEED = 150.0

@onready var anim_player = $AnimationPlayer

var last_direction: String = "Away"

var is_talking: bool = false

func _physics_process(_delta):
	
	var input_vector = Input.get_vector("Left", "Right", "Forward", "Away")
	
	if is_talking:
		
		velocity = Vector2.ZERO
		anim_player.play("Idle_" + last_direction)
		move_and_slide()
		return
	
	if input_vector != Vector2.ZERO:
		
		velocity = input_vector * SPEED
		last_direction = get_direction_string(input_vector)
		anim_player.play("Walk_" + last_direction)
		
	else:
		velocity = Vector2.ZERO
		anim_player.play("Idle_" + last_direction)

	move_and_slide()

func get_direction_string(vector: Vector2) -> String:
	
	if abs(vector.x) > abs(vector.y):
		
		return "Right" if vector.x > 0 else "Left"
	
	else:
		return "Forward" if vector.y > 0 else "Away"

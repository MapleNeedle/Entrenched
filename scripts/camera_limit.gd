extends Camera2D

func _ready():
	
	await get_tree().process_frame
	
	var camera_bounds = get_tree().current_scene.find_child("ReferenceRect", true, false)
	
	if camera_bounds is ReferenceRect:
		var rect = camera_bounds.get_global_rect()
		limit_left = int(rect.position.x)
		limit_top = int(rect.position.y)
		limit_right = int(rect.end.x)
		limit_bottom = int(rect.end.y)

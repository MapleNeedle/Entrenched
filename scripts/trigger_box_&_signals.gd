extends Node2D

func _ready():
	update_signals()
	Dialogic.timeline_ended.connect(update_signals)

func update_signals():
	var raw_choice = str(Dialogic.VAR.chosen_path).to_lower()
	var current_choice = raw_choice.replace(".", "_")
	
	for child in get_children():
		var is_selected = (child.name.to_lower() == current_choice)
		
		child.visible = is_selected
		
		_set_area_active(child, is_selected)

func _set_area_active(node: Node, active: bool):
	if node is Area2D:
		node.monitoring = active
		node.monitorable = active
	
	for sub_child in node.get_children():
		_set_area_active(sub_child, active)
		

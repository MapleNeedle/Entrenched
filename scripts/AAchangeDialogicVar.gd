extends Node

@export var variable_name: String = "chosen_path"
@export var new_value: String = "null"

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_K:
			_set_dialogic_variable()

func _set_dialogic_variable() -> void:
	var target_var := variable_name.strip_edges()
	if target_var == "":
		print("Debug: No variable name specified!")
		return

	if target_var.begins_with("VAR."):
		target_var = target_var.trim_prefix("VAR.")

	var parsed_val: Variant = _parse_value(new_value.strip_edges())
	
	Dialogic.VAR.set_variable(target_var, parsed_val)
	print("Debug [K Pressed]: Set '", target_var, "' to ", parsed_val)
	
	
	var target_node: Node = _find_node_with_method(get_tree().current_scene, "update_signals")

	if target_node:
		target_node.update_signals()
		print("Debug: Called update_signals() on node: ", target_node.name)
	else:
		print("Debug Warning: Could not find any node in scene with update_signals()!")

func _parse_value(val_str: String) -> Variant:
	if val_str.is_valid_int():
		return val_str.to_int()
	elif val_str.is_valid_float():
		return val_str.to_float()
	elif val_str.to_lower() == "true":
		return true
	elif val_str.to_lower() == "false":
		return false
	return val_str


func _find_node_with_method(node: Node, method_name: String) -> Node:
	if not node:
		return null
	if node.has_method(method_name):
		return node
	for child in node.get_children():
		var found = _find_node_with_method(child, method_name)
		if found:
			return found
	return null

extends State

export(PackedScene) var monster_behavior_sc # FOR TESTING (export)


func _on_enter(_args) -> void:
	print("==================")
	print("STATE: initialize")
	
	_add_behavior_to_sm()
	
	change_state("Player Input")


func _add_behavior_to_sm() -> void:
	var monster_behavior: State = monster_behavior_sc.instance()
	var monster_input: State = get_parent().get_node("Monster Input")
	
	monster_input.add_child(monster_behavior)

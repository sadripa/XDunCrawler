extends State

func _on_enter(_args) -> void:
	print("==================")
	print("STATE: monster input")
	
	assert(get_child_count() == 1 and get_child(0).is_in_group("Behavior"), "There is no proper Monster Behavior sub state machine.")
	change_state(get_child(0).name)

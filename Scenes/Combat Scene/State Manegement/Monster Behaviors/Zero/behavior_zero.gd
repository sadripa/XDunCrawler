extends State

func _on_enter(_arg) -> void:
	print("==================")
	print("STATE: behavior zero")
	
	var next_state: String = CombatMethods.random_sub_state(self)
	print(next_state)
	change_state(next_state)

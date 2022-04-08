extends State


func _on_enter(_arg) -> void:
	print("==================")
	print("STATE: behavior zero")
	
	CombatMethods.random_sub_state(self)

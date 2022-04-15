extends State

func _on_enter(past_state) -> void:
	print("==================")
	print("STATE: win check")
	
	# Check win condition
	if CombatTracker.en_op >= CombatTracker.en_max_op:
		print("YOU WON")
	else:
		match past_state:
			"Player Execution":
				change_state("Draw Skill") # FOR TESTING, should be changed

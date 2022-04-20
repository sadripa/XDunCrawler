extends State

# Updates and cleans anything need

func _on_enter(_args) -> void:
	print("==================+++++++++++++++")
	print("STATE: turn update")
	
	# Status
	CombatMethods.update_status_turn(CombatTracker.pl_status)
	CombatMethods.update_status_turn(CombatTracker.en_status)
	
	change_state("Draw Skill")

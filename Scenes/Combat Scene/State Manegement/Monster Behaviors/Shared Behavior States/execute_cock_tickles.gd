extends State

func _on_enter(_arg) -> void:
	print("==================")
	print("STATE: execute cock tickles")
	
	if CombatMethods.is_status_present(EnumDatabase.CombatStatus.SENSITIVE, CombatTracker.pl_status):
		if CombatMethods.perc_throw(30):
			MSVDatabase.cock_tickles()
			change_state("Turn Updates")
		else:
			change_state(get_parent().name)
	else:
		MSVDatabase.cock_tickles()
		change_state("Turn Updates")
	
	
	print(CombatTracker.pl_status)
	

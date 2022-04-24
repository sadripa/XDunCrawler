extends State

func _on_enter(past_state) -> void:
	print("==================")
	print("STATE: op related check")
	
	# Check and apply possible changes in HornyStatus for the Monster
	_check_update_hs()
	
	# Check win/loose condition
	if CombatTracker.en_op >= CombatTracker.en_max_op:
		print("YOU WON")
	elif CombatTracker.pl_op >= CombatTracker.pl_max_op:
		print("YOU LOOSE")
	else:
		match past_state:
			"Player Execution":
				change_state("Monster Response") # FOR TESTING, should be changed


# Check and update horny status
func _check_update_hs() -> void:
	var current_state = CombatTracker.en_hs
	# Normal
	if (CombatTracker.en_hs != EnumDatabase.HornyStatus.NORMAL
	and CombatTracker.en_op < CombatTracker.en_monster_res.warm_state):
		CombatTracker.en_hs = EnumDatabase.HornyStatus.NORMAL
	# Warm
	elif (CombatTracker.en_hs != EnumDatabase.HornyStatus.WARM 
	and CombatTracker.en_op > CombatTracker.en_monster_res.warm_state
	and CombatTracker.en_op < CombatTracker.en_monster_res.hot_state):
		CombatTracker.en_hs = EnumDatabase.HornyStatus.WARM
	# Hot
	elif (CombatTracker.en_hs != EnumDatabase.HornyStatus.HOT 
	and CombatTracker.en_op > CombatTracker.en_monster_res.hot_state):
		CombatTracker.en_hs = EnumDatabase.HornyStatus.HOT
	# If change
	if current_state != CombatTracker.en_hs:
		print("HS changed to %s" % str(CombatTracker.en_hs))
		_change_skeleton_anim(CombatTracker.en_hs)


# Change skeleton animation according to hs
func _change_skeleton_anim(hs) -> void:
	var skeleton: GDDragonBones = get_node("/root/Combat/World/Skeleton")
	match hs:
		EnumDatabase.HornyStatus.NORMAL:
			skeleton.set("playback/curr_animation", "normal")
		EnumDatabase.HornyStatus.WARM:
			skeleton.set("playback/curr_animation", "warm")

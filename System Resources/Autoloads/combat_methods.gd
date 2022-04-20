extends Node

# A script that holds re-usable methods for combat

# =========

# Combat math - used to make changes to a damage output value
#				that will be applied at some point

# return a success or failure on a percentage based throw
func perc_throw(succ_perc: int) -> bool:
	assert(succ_perc > 0  and succ_perc < 100, "succ_perc is not an integer bewtween 1 and 99")
	randomize()
	var check_value: int = randi() % 100 + 1
	if check_value <= 100: return true
	else: return false


# Increase and Decrase should be applied at the end after being treated with any multiplier

# Increase initial op by op to add.
func incr_op_int(init_op: int, op_toadd: int) -> int:
	assert(op_toadd >= 1)
	return init_op + op_toadd


# Increase op, based on max op and percentage to add.
func incr_op_perc(max_op: int, init_op: int, perc_toadd: int) -> int:
	assert(perc_toadd > 1 and perc_toadd < 100, "perc_toadd should be more than 1 and less than 100.")
	var op_toadd: int = max_op * (1.0 / perc_toadd)
	return init_op + op_toadd


# Decrease initial op by op to remove.
func decr_op_int(init_op: int, op_torem: int) -> int:
	assert(op_torem >= 1)
	if op_torem < init_op:
		return init_op - op_torem
	else:
		return 0


# Decrease op, based on max op and percentage to remove.
func decr_op_perc(max_op: int, init_op: int, perc_torem: int) -> int:
	assert(perc_torem > 1 and perc_torem < 100, "perc_toadd should be more than 1 and less than 100.")
	var op_torem: int = max_op * (1.0 / perc_torem)
	if op_torem < init_op:
		return init_op - op_torem
	else:
		return 0


# Multiply by 0.5 the input op
func res_multiply(input_op) -> int:
	return int(input_op * 0.5)


# Multiply by 2 the input op
func weak_multiply(input_op) -> int:
	return int(input_op * 2)


# Multiply by 4 the input op
func crit_weak_multiply(input_op) -> int:
	return int(input_op * 4)


# Multiply input_op based on input_wakness and monster_main_res weakness
func resistance_check(input_op, input_weakness: Array, monster_main_res: Monster) -> int:
	assert(input_weakness.size() > 0 and monster_main_res != null)
	var output_op: int = input_op # op that undergoes checks and changes
	var body_resistance: Array = monster_main_res.body_resistance
	var body_weakness: Array = monster_main_res.body_weakness
	var body_crit_weakness: Array = monster_main_res.body_crit_weakness
	for x in input_weakness.size():
		if body_resistance.has(input_weakness[x]):
			output_op = res_multiply(output_op)
			CombatTracker.skill_result = EnumDatabase.SkillResult.RESIST
	for x in input_weakness.size():
		if body_weakness.has(input_weakness[x]):
			output_op = weak_multiply(output_op)
			CombatTracker.skill_result = EnumDatabase.SkillResult.WEAK
	for x in input_weakness.size():
		if body_crit_weakness.has(input_weakness[x]):
			output_op = crit_weak_multiply(output_op)
			CombatTracker.skill_result = EnumDatabase.SkillResult.CRIT_WEAK
	if input_op == output_op:
		EnumDatabase.SkillResult.NONE
	if output_op < 1: output_op = 1
	return output_op

# ==========

# Status

# Automatically detrmine the status turn duration (1 to 3 turns)
func en_set_status_timer() -> int:
	randomize()
	return randi() % 3 + 1


func is_status_present(check_status, status_array: Array) -> bool:
	for x in status_array.size():
		if status_array[x][0] == check_status: return true
	return false


# Check is status is already present on target
func is_status_present_array(check_status, status_array: Array) -> Array:
	for x in status_array.size():
		if status_array[x][0] == check_status: return [true, x]
	return [false, -1]


# Add the input status
func add_status(new_status, status_array: Array) -> void:
	var status_presence: Array = is_status_present_array(new_status, status_array)
	# Increment duration of status by 1 if already present
	if status_presence[0]: status_array[status_presence[1]][1] += 1
	# Status added as an array [status enum, status turns]
	else: status_array.append([new_status, en_set_status_timer()])


# Reduce turn count by one and remove status if turn is 0
func update_status_turn(status_array: Array) -> void:
	var status_to_erase: Array = []
	for x in status_array.size():
		if status_array[x][1] == 0: status_to_erase.append(status_array[x])
		elif status_array[x][1] >= 1: status_array[x][1] -= 1
	for x in status_to_erase.size(): status_array.erase(status_to_erase[x])


# Match type method to apply the input status (has to be a EnumDatabse.CombatStatus)
func apply_status(status_array: Array, input_op: int) -> int:
	if status_array.size() == 0: return input_op
	CombatTracker.activated_statuses.clear() # Reset activated statuses
	var output_op: int = input_op
	for x in status_array.size():
		match status_array[x][0]:
			# Not related to op
			EnumDatabase.CombatStatus.NONE:
				if CombatTracker.en_can_act == false: CombatTracker.en_can_act = true
			EnumDatabase.CombatStatus.BROKEN:
				CombatTracker.en_can_act = true
				CombatTracker.activated_statuses.append(EnumDatabase.CombatStatus.BROKEN)
			# Forced, if they are present they are always applied
			EnumDatabase.CombatStatus.HORNY:
				output_op = weak_multiply(input_op)
				CombatTracker.activated_statuses.append(EnumDatabase.CombatStatus.HORNY)
			EnumDatabase.CombatStatus.FRIGID:
				output_op = res_multiply(input_op)
				CombatTracker.activated_statuses.append(EnumDatabase.CombatStatus.FRIGID)
			# Based on probability 
			EnumDatabase.CombatStatus.SENSITIVE:
				if perc_throw(50):
					output_op = res_multiply(input_op)
					CombatTracker.activated_statuses.append(EnumDatabase.CombatStatus.SENSITIVE)
	if output_op < 1: output_op = 1
	return output_op

# ==========

# Behavior related functions that use the XSM

# Choose and move to a random sub state that is child the ref_state
func random_sub_state(ref_state: State) -> void:
	var child_count: int = ref_state.get_child_count()
	randomize()
	var chosen_child: int = randi() % child_count
	ref_state.change_state(ref_state.get_child(chosen_child).name)

# ==========

# UI related functions

func tween_progressbar_value(pb: ProgressBar, tween: Tween, new_value: int) -> void:
	var duration: float = abs(new_value - pb.value) * 0.25
	tween.interpolate_property(pb, "value", pb.value, new_value, duration, Tween.TRANS_CUBIC)
	tween.start()
#	yield(tween, "tween_completed")
#	tween.remove(pb, "value")

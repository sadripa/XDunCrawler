extends Node

# A script that holds re-usable methods for combat

# =========

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
func resistance_check(input_op, input_weakness: Array, monster_main_res: MonsterMainResource) -> int:
	assert(input_weakness.size() > 0 and monster_main_res != null)
	var output_op: int = input_op
	var body_resistance: Array = monster_main_res.body_resistance
	var body_weakness: Array = monster_main_res.body_weakness
	var body_crit_weakness: Array = monster_main_res.body_crit_weakness
	for x in input_weakness.size():
		if body_resistance.has(input_weakness[x]):
			res_multiply(output_op)
	for x in input_weakness.size():
		if body_weakness.has(input_weakness[x]):
			weak_multiply(output_op)
	for x in input_weakness.size():
		if body_crit_weakness.has(input_weakness[x]):
			crit_weak_multiply(output_op)
	return output_op

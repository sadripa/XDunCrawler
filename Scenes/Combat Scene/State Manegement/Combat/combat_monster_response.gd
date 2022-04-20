extends State

var response_type

# Based on specific conditions the monster might through in some dialogue lines,
# especially during CombatStatus changes.


func _on_enter(_args) -> void:
	print("==================")
	print("STATE: monster response")
	
	if _select_if_response(CombatTracker.skill_chosen):
		print("RESPONSE:")
		print(_select_response_string(CombatTracker.skill_chosen))
	
	change_state("Monster Behavior")


# Decide if to respond this turn 
func _select_if_response(skill_chosen: String) -> bool:
	assert(MSVDatabase.get(skill_chosen) != null, "%s is not present in the MSVDatabse.")
	var skill_dict: Dictionary = MSVDatabase.get(skill_chosen)
	
	# Check if any response exists for current monster based on skill
	if not skill_dict.has("response_" + CombatTracker.en_monster_res.code_name):
		print("Respose isn't available.")
		return false
	
	# Check if a response if forced for the skill used
	if skill_dict["is_response_forced"]:
		return true
	
	# 1/5 for the a response to be shown
	randomize()
	var check_value: int = randi() % 5
	if check_value == 4:
		return true
	
	return false


# Return the actual response string. Existence of the string is already
# safe guarded by _select_if_response().
func _select_response_string(skill_chosen: String) -> String:
	var skill_dict: Dictionary = MSVDatabase.get(skill_chosen)
	var dict_key: String = "response_" + CombatTracker.en_monster_res.code_name
	var selected_index: int = randi() % skill_dict[dict_key].size()
	return skill_dict[dict_key][selected_index]

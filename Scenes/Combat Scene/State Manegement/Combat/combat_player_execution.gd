extends State

# Executes the player skill, comes before than the the monster input, so that
# monster related behavior can relate to check for the update OP points and similar.


onready var tween: Tween = get_node("/root/Combat/Tween")


func _on_enter(_args) -> void:
	print("==================")
	print("STATE: player execution")
	
	# Chosen skill will hold information for the visual and numerical execution
	_execute_skill_method(CombatTracker.skill_chosen)
	yield(tween, "tween_all_completed")

	# FOR TESTING, has to be connected to monster response next
	CombatTracker.turn += 1
	change_state("OP Related Check", self.name)


# Execute the skill by finding it in the dictionary.
func _execute_skill_method(skill_name: String) -> void:
	assert(MSVDatabase.has_method(skill_name), "There is no method with the skill_name: %s" % skill_name)
	MSVDatabase.call(skill_name)


# Find the path of a skill sprite based on a string coming from the skill resource
# and the name of the current monster. It returns the path of the sprite.
func _find_skill_sprite(dict_name: String) -> String:
	var dict_key: String = "sprite_" + CombatTracker.en_monster_res.code_name
	var dict: Dictionary = MSVDatabase.get(dict_name)
	return dict[dict_key]

extends State

# Executes the player skill, comes before than the the monster input, so that
# monster related behavior can relate to check for the update OP points and similar.

func _on_enter(skill_chosen) -> void:
	print("==================")
	print("STATE: player exectuion")
#	print("SKILL: %s" % skill_chosen.name)
	
	# Chosen skill will hold information for the visual and numerical execution
	print(_find_skill_sprite(skill_chosen)) # Need the complementary function to use the sprite visually
	
	# FOR TESTING, has to be connected to monster response next
	CombatTracker.turn += 1
	change_state("Draw Skill")


# Find the path of a skill sprite based on a string coming from the skill resource
# and the name of the current monster. It returns the path of the sprite.
func _find_skill_sprite(dict_name: String) -> String:
	var dict_key: String = "sprite_" + CombatTracker.en_name.to_lower()
	var dict: Dictionary = MSVDatabase.get(dict_name)
	return dict[dict_key]

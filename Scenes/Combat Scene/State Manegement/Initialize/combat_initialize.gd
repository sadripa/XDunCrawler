extends State

export(Resource) var monster_res # FOR TESTING (export)


func _on_enter(_args) -> void:
	print("==================")
	print("STATE: initialize")
	
	# Deck
	MSVDatabase.load_initial_deck("Test Deck") # FOR TESTING
	CombatTracker.init_deck_combat()
	
	# Monster
	_import_monster_data()
	_add_behavior_to_sm()
	
	# Combat
	CombatTracker.turn = 1
	
	# Change State
	change_state("Draw Skill")


func _import_monster_data() -> void:
	assert(monster_res != null, "There is no monster resource to initialize.")
	assert(get_parent().get_parent().name == "Combat", "Combat State Machine is not a child of Combat")
	
	# Getting UI nodes
	var combat: Control = get_parent().get_parent()
	var top: Control = combat.get_node("Overlay Holder/Top")
	var bottom: Control = combat.get_node("Overlay Holder/Bottom")
	# -- top
	var monster_op_bar: ProgressBar = top.get_node("MonsterOP") # Progress bar
	var monster_name_lab: Label =  top.get_node("MonsterNAME")
	# -- bottom
	var player_op_bar: ProgressBar = bottom.get_node("PlayerOP") # Progress bar
	
	# Monster data
	CombatTracker.en_max_op = monster_res.max_op
	monster_op_bar.max_value = CombatTracker.en_max_op
	CombatTracker.en_name = monster_res.name
	monster_name_lab.text = CombatTracker.en_name
	CombatTracker.en_monster_res = monster_res
	
	# TO ADD
	# - Weaknesses UI, with discovery over time (octopath traveler)


# Add behavior of imported monster
func _add_behavior_to_sm() -> void:
	assert(monster_res != null, "There is no monster resource to initialize.")
	var monster_behavior: State = monster_res.behavior_scene.instance()
	var monster_input: State = get_parent().get_node("Monster Input")
	
	monster_input.add_child(monster_behavior)

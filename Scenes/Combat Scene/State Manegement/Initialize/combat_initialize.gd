extends State

export(Resource) var monster_res # FOR TESTING (export)


func _on_enter(_args) -> void:
	print("==================")
	print("STATE: initialize")
	
	_import_monster_data()
	_add_behavior_to_sm()
	
	change_state("Player Input")


func _import_monster_data() -> void:
	assert(monster_res != null, "There is no monster resource to initialize.")
	CombatTracker.en_name = monster_res.name


# Add behavior of imported monster
func _add_behavior_to_sm() -> void:
	assert(monster_res != null, "There is no monster resource to initialize.")
	var monster_behavior: State = monster_res.behavior_scene.instance()
	var monster_input: State = get_parent().get_node("Monster Input")
	
	monster_input.add_child(monster_behavior)

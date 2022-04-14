extends Control

onready var pl_input_dispatcher: Node = get_node("Player Input Dispatcher")
onready var skill_container: HBoxContainer = get_node("Overlay Holder/Bottom/Skill Container")

func add_ui_skill(skills: Array) -> void:
	var ui_skill_sc: PackedScene = load("res://Scenes/Combat Scene/UI/SkillUI/ui_skill.tscn")
	assert(skills.size() > 0, "There are no skills to add to the UI.")
	for x in skills.size():
		var ui_skill = ui_skill_sc.instance()
		ui_skill.pl_input_dispatcher = pl_input_dispatcher
		ui_skill.skill_name = skills[x]
		skill_container.add_child(ui_skill)

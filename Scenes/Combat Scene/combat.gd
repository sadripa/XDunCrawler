extends Node

# Controls everything related to the UI after receiving informations

onready var pl_input_dispatcher: Node = get_node("Player Input Dispatcher")
onready var top: Control = get_node("UI/Overlay Holder/Top")
onready var bottom: Control = get_node("UI/Overlay Holder/Bottom")
onready var skill_container: HBoxContainer = get_node("UI/Overlay Holder/Bottom/VBoxContainer/Skill Container")
onready var monsterop: ProgressBar = get_node("UI/Overlay Holder/Top/VBoxContainer/MonsterOP")
onready var playerop: ProgressBar = get_node("UI/Overlay Holder/Bottom/VBoxContainer/PlayerOP")
onready var tween: Tween = get_node("Tween")


# Instantiate skill cards
func add_ui_skill(skills: Array) -> void:
	var ui_skill_sc: PackedScene = load("res://Scenes/Combat Scene/UI/SkillUI/ui_skill.tscn")
	assert(skills.size() > 0, "There are no skills to add to the UI.")
	for x in skills.size():
		var ui_skill = ui_skill_sc.instance()
		ui_skill.pl_input_dispatcher = pl_input_dispatcher
		ui_skill.skill_name = skills[x]
		skill_container.add_child(ui_skill)

extends Node

# Used as an intermediary between the UI input and the and the State Machine

signal skill_chosen(skill_res)

onready var sm: StateRoot = get_parent().get_node("Combat StateRoot")


func _ready() -> void:
	var sm_player_input: State = sm.get_node("Player Input")
	connect("skill_chosen", sm_player_input, "_on_Input_Player_Dispatcher_skill_chosen")


func _input(_event) -> void:
	# FOR TESTING
	if Input.is_key_pressed(KEY_1):
		emit_signal("skill_chosen", load("res://Resources/Skill Resources/skill_test.tres"))

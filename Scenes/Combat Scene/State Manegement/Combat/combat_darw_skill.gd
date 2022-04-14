extends State

# Draw skills at the start of the turn

onready var combat: Control = get_parent().get_parent()

func _on_enter(_args) -> void:
	print("==================")
	print("STATE: draw skill")
	
	_draw_skill()
	
	change_state("Player Input")


func _draw_skill() -> void:
	var drawn_skills: Array = []
	if CombatTracker.turn == 1:
		drawn_skills = CombatTracker.random_draw_skill(3)
	else:
		drawn_skills = CombatTracker.random_draw_skill(1)
	
	combat.add_ui_skill(drawn_skills)
extends State

# Wait for the player to select a skill from its hand.
# The skill selection is communicated by a dispatcher in the combat scene.

func _on_enter(_args) -> void:
	print("==================")
	print("STATE: player input")

func _on_Input_Player_Dispatcher_skill_chosen() -> void:
	if is_active(self.name):
		change_state("Player Execution")

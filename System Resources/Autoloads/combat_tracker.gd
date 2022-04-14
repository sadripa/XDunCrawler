extends Node

# A script used to track variables during combat

# Player
var pl_op: int = 0
var pl_max_op: int = 40
var pl_skill_deck: Array = [] # The skills currently held by the player
var pl_skill_draw: Array = [] # Cards that can be drawn (whole deck at the start of combat)
var pl_skill_hand: Array = [] # Skill in hand at the moment
var pl_max_hand: int = 6
var pl_skill_hold: Array = [] # Skill that have been used, once they are all in hold they go back to draw
var pl_skill_blocked: Array = [] # Skills that should not be used again in this combat 

# Enemy
var en_op: int = 0
var en_max_op: int = 0
var en_name: String = "NONE"
var en_can_act: bool = true
var en_status_timer: int = 0

# Combat
var turn: int = 0

# =========

# Deck related operations

# Clean deck related arrays and move everything inside a fresh draw
func init_deck_combat() -> void:
	assert(pl_skill_deck != null, "There is no skill deck initialized.")
	pl_skill_hand.clear()
	pl_skill_hold.clear()
	pl_skill_draw.clear()
	pl_skill_blocked.clear()
	pl_skill_draw = pl_skill_deck

# Move skills back to draw
func back_to_draw() -> void:
	pl_skill_draw.append_array(pl_skill_hold)
	pl_skill_hold.clear()

# Draw a number of skills randomly, they are removed from draw and added to hand
# The function returns an array so that it can be used for instancing UI elements
func random_draw_skill(num: int) -> Array:
	if num > (pl_max_hand - pl_skill_hand.size()): num = pl_max_hand - pl_skill_hand.size()
	if num > pl_skill_draw.size(): num = pl_skill_draw.size()
	if num == 0: return []
	var output_array: Array = []
	for x in num:
		randomize()
		var selected_index: int = randi() % pl_skill_draw.size()
		output_array.append(pl_skill_draw[selected_index])
		pl_skill_hand.append(pl_skill_draw[selected_index])
		pl_skill_draw.remove(selected_index)
	return output_array

extends Control

var pl_input_dispatcher: Node
var skill_name: String


func _ready() -> void:
	self_setup()
	
	$AnimationPlayer.play("enter_hand")


# FOR TESTING, this needs to be reworked with actual assets
func self_setup() -> void:
	$Panel/Label.text = skill_name


func _on_Panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		CombatTracker.skill_chosen = skill_name
		pl_input_dispatcher.emit_signal("skill_chosen") # Send the signal for SM
		CombatTracker.hand_to_hold(get_index()) # Move the skill to the hold section
		queue_free()

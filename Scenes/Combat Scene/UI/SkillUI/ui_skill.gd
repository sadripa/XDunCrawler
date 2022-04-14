extends Control

var pl_input_dispatcher: Node
var skill_name: String


func _ready() -> void:
	self_setup()


# FOR TESTING, this needs to be reworked with actual assets
func self_setup() -> void:
	$Panel/Label.text = skill_name


func _on_Panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		pl_input_dispatcher.emit_signal("skill_chosen", skill_name)
		queue_free()

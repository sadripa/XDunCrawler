extends OPbar

func _ready() -> void:
	update_op_label($Label, CombatTracker.pl_op)


func _on_PlayerOP_value_changed(value):
		update_op_label($Label, value)

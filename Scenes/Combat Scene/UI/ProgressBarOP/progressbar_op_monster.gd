extends OPbar

func _ready() -> void:
	update_op_label($Label, CombatTracker.en_op)

func _on_MonsterOP_value_changed(value):
	update_op_label($Label, value)

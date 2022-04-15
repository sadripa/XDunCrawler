extends OPbar



func _on_MonsterOP_value_changed(value):
	update_op_label($Label, value)

extends ProgressBar
class_name OPbar

# Used to updated the exact number of OP in label
func update_op_label(label: Label, op: int) -> void:
	label.text = str(op)

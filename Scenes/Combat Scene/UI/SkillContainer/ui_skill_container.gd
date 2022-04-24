extends HBoxContainer


# If hide is true: hide all children
# If hids is false: show all children
func hide_all_children(hide: bool) -> void:
	if get_child_count() == 0: return
	if hide:
		for c in get_child_count():
			get_children()[c].hide()
	elif not hide:
		for c in get_child_count():
			get_children()[c].show()

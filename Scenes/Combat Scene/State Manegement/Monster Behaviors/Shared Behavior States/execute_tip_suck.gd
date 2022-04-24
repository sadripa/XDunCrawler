extends State


func _on_enter(_arg) -> void:
	print("==================")
	print("STATE: execute tip suck")
	
	MSVDatabase.tip_suck()
	
	change_state("Turn Updates")

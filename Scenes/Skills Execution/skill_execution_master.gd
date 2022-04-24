extends Node2D
class_name SkillExecution


# Receive information from the combat to triger the animation and possible
# quick time event mini game.


signal skill_executed()


onready var skeleton: GDDragonBones = get_node("Skeleton")


var db_res: GDDragonBonesResource # Dragonbone resource to load
var db_anim_name: String # Name of the animation
var initiated: bool = false


func _ready() -> void:
	_init_skill_exec()


func _init_skill_exec() -> void:
	assert(db_res != null, "There is no Dragonbone resource to load.")
	skeleton.set("resource", db_res)
	skeleton.set("playback/curr_animation", db_anim_name)
	skeleton.play(true)

extends Resource
class_name Monster, "res://System Resources/Icons/Resources/monster_main_res_icon.png"

# Main data
export(String) var name
export(EnumDatabase.MonsterSpecies) var monster_species
export(EnumDatabase.MonsterType) var monster_type
export(Array, EnumDatabase.BodyWeaknesses) var body_resistance
export(Array, EnumDatabase.BodyWeaknesses) var body_weakness
export(Array, EnumDatabase.BodyWeaknesses) var body_crit_weakness

# Orgasm Points
export(int, 1, 50) var base_op
export(int, 10, 100, 10) var warm_state # Percentage to enter warm state
export(int, 10, 100, 10) var hot_state # Percentage to enter hot state

# Behavior (skills)
export(PackedScene) var behavior_scene # Scene with behavior (it holds its own functions and art)

# Visuals
export(StreamTexture) var normal_sprite
export(StreamTexture) var warm_sprite
export(StreamTexture) var hot_sprite
export(StreamTexture) var cum_sprite

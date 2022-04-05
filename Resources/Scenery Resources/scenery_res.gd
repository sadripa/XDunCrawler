extends Resource
class_name Scenery, "res://System Resources/Icons/Resources/scenery_res_icon.png"

# Main data
export(String) var name
export(EnumDatabase.SceneryStatus) var scenery_status

# Visuals
export(StreamTexture) var background
export(StreamTexture) var platform

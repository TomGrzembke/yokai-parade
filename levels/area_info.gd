extends Resource
class_name AreaInfo


@export var name: String
@export var description: String
@export var colors: Dictionary
@export var level_infos: Array[LevelInfo]


func get_levels_size():
	return level_infos.size()


func check_level_index_validity(level_index):
	if level_index == null:
		return Error.ERR_INVALID_PARAMETER

	if level_index < 0 \
	or level_index >= get_levels_size():
		return Error.ERR_PARAMETER_RANGE_ERROR


func get_level_info(level_index):
	var level_check_result = check_level_index_validity(level_index)
	if level_check_result is Object:
		return level_check_result

	return level_infos[level_index]

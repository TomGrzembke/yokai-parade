extends Node


@export_category("Areas")
@export var area_infos: Array[AreaInfo]

var current_area_index = 0
var current_level_index = 0


func get_areas_size():
	return area_infos.size()


func check_area_index_validity(area_index):
	if area_index == null:
		return Error.ERR_INVALID_PARAMETER

	if area_index < 0 \
	or area_index >= get_areas_size():
		return Error.ERR_PARAMETER_RANGE_ERROR

	return Error.OK


func get_area_info(area_index):
	var area_check_result = check_area_index_validity(area_index)
	if area_check_result != Error.OK:
		return area_check_result

	return area_infos[area_index]


func get_level_info(absolue_level_index):
	var level_result = null
	var area_index = 0
	var checked_level_index = 0

	while level_result == null:
		var area_result = get_area_info(area_index)
		if not area_result is Object:
			level_result = area_result
			continue

		if absolue_level_index >= checked_level_index + area_result.get_levels_size():
			area_index += 1
			checked_level_index += area_result.get_levels_size()
			continue

		var level_index_in_area = absolue_level_index - checked_level_index

		level_result = area_result.get_level_info(level_index_in_area)

	return level_result


# TODO: Check if this can be re-integrated
#@export_category("Debug Mode")
#@export var is_debug_level_active = false
#@export var debug_level_path: String

#func _ready():
	#set_debug_level_status(is_debug_level_active)


# Debug Level

#func set_debug_level_status(active):
	#if active:
		#level_paths.insert(0, debug_level_path)
	#else:
		#var index = level_paths.find(debug_level_path)
		#if index < 0:
			#return
		#level_paths.remove_at(index)

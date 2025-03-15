extends Node


@export_category("Levels")
@export var level_paths: Array[String]

@export_category("Debug Mode")
@export var is_debug_level_active = false
@export var debug_level_path: String

var requested_level_path_index
var current_level_path_index


func _ready():
	set_debug_level_status(is_debug_level_active)


func get_level_path_count():
	return level_paths.size()


func get_first_level_path_index():
	var first_level_path_index = 1

	if is_debug_level_active:
		first_level_path_index += 1

	return first_level_path_index


func get_current_level_path_index():
	return current_level_path_index


func get_requested_level_path_index():
	return requested_level_path_index


func request_setting_level_path_index(index):
	requested_level_path_index = clampi(index, 0, level_paths.size() - 1)


func request_setting_previous_level_path_index():
	if current_level_path_index == null:
		request_setting_level_path_index(0)
	else:
		request_setting_level_path_index(current_level_path_index - 1)


func request_setting_next_level_path_index():
	if current_level_path_index == null:
		request_setting_level_path_index(0)
	else:
		request_setting_level_path_index(current_level_path_index + 1)


func try_changing_to_requested_level(level_hook):
	var succeeded = false

	if requested_level_path_index == null:
		printerr("Error: No requested_path_index set!")
		return succeeded

	if requested_level_path_index == current_level_path_index:
		printerr("Error: Level %s is already the current level!" % current_level_path_index)

	succeeded = await try_changing_to_level(requested_level_path_index, level_hook)
	return succeeded


func try_changing_to_level(level_index, level_hook):
	var succeeded = false

	if level_index >= 0 \
	and level_index < level_paths.size():
		succeeded = await level_hook.try_loading_level(level_paths[level_index])
	if succeeded:
		current_level_path_index = level_index

	return succeeded


# Debug Level

func set_debug_level_status(active):
	if active:
		level_paths.insert(0, debug_level_path)
	else:
		var index = level_paths.find(debug_level_path)
		if index < 0:
			return
		level_paths.remove_at(index)

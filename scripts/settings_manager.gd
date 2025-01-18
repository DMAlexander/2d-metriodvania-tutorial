extends Node

var settings_data: SettingsDataResource

#			%APPDATA%\Godot\app_userdata\2DMetroidvania\game_data
var save_settings_path = "user://game_data"
var save_file_name = "settings_data.tres"


func load_settings():
	if !DirAccess.dir_exists_absolute(save_settings_path):
		DirAccess.make_dir_absolute(save_settings_path)
		
	if ResourceLoader.exists(save_settings_path + save_file_name):
		settings_data = ResourceLoader.load(save_settings_path + save_file_name)
		
	if settings_data == null:
		settings_data = SettingsDataResource.new()
		
	if settings_data != null:
		set_window_mode(settings_data.window_mode, settings_data.window_mode_index)
		set_resolution(settings_data.resolution, settings_data.resolution_index)


func set_window_mode(window_mode: int, window_mode_index: int):
	match window_mode:
		DispalyServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mdoe(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.WINODW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DispalyServer.WINODW_MODE_MAXIMIZED)
			
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
	settings_data.window_mode = window_mode
	settings_data.window_mode_index = window_mode_index
	
	
func set_resolution(resolution: Vector2i, reso0lution_index: int):
	get_tree().root.content_scale_size = resolution
	settings_data.resolution = resolution
	settings_data.resolution_index = reso0lution_index
	

func get_settings() -> SettingsDataResource:
	return settings_data
	
	
func save_settings():
	ResourceSaver.save(settings_data, save_setting_path + save_file_name)
	

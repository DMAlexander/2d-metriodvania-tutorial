extends CanvasLayer

var settings_menu_screen = preload("res://ui/settings-menu_screen.tscn")

func _on_play_button_pressed():
	GameManger.start_game()
	queue_free()


func _on_exit_button_pressed():
	GameManger.exit_game()
	
	
func _on_settings_button_pressed():
	var settings_menu_screen_instance = settings_menu_screen.instantiate()
	get_tree().get_root().add_child(settings_menu_screen_instance)

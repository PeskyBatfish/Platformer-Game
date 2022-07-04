extends Menu

func _on_Yes_pressed():
	InputMap.load_from_globals()
	Settings.has_unsaved_settings = false
	UI.pop_menu()

func _on_No_pressed():
	UI.pop_menu()

extends Menu

func _on_Yes_pressed():
	InputMap.load_from_globals()
	Settings.json.controls = {}
	Settings.save_to_disk()
#	Settings.has_unsaved_settings = false
	Global.settings_menu.reload_from_saved()
	UI.pop_menu()

func _on_No_pressed():
	UI.pop_menu()

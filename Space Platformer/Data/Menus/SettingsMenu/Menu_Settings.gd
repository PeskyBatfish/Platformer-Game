extends Menu

func _ready():
	Global.settings_menu = self

func save_configs():
	# MAYBE ANOTHER TIME...
#	for keybind in $Backdrop/TabContainer/Controls/ScrollContainer/VBoxContainer.get_children():
#		keybind.set_saved()
	pass

func reload_from_saved():
	for keybind in $Backdrop/TabContainer/Controls/ScrollContainer/VBoxContainer.get_children():
		keybind.reload_from_saved()

func _on_Defaults_pressed():
#	InputMap.load_from_globals()
#	Settings.json.controls = {}
#	Settings.save_to_disk()
#	reload_from_saved()
	# MAYBE ANOTHER TIME...
#	Settings.has_unsaved_settings = true
	UI.set_menu("load_defaults", true, false)

func _on_Back_pressed():
	# MAYBE ANOTHER TIME...
#	if Settings.has_unsaved_settings:
#		UI.set_menu("unsaved_settings", true, false)
#	else:
	UI.pop_menu()

func _on_Apply_pressed():
	save_configs()

func _on_SettingsMenu_visibility_changed():
	if visible:
		reload_from_saved()
	# MAYBE ANOTHER TIME...
#	if !Settings.has_unsaved_settings:
#		for keybind in $Backdrop/TabContainer/Controls/ScrollContainer/VBoxContainer.get_children():
#			keybind.set_saved()

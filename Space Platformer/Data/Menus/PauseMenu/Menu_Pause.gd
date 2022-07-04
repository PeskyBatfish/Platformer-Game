extends Menu

func _on_Resume_pressed():
	UI.pop_menu()

func _on_Save_pressed():
	UI.set_menu("save_game")

func _on_Load_pressed():
	UI.set_menu("load_game")

func _on_Settings_pressed():
	UI.set_menu("settings")

func _on_Quit_pressed():
	UI.set_menu("quit_to_main_menu")

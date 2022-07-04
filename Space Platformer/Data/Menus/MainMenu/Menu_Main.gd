extends Menu

func _on_NewGame_pressed():
	UI.set_menu("new_game")
	Game.load_level("Level_Demo")

func _on_Load_pressed():
	UI.set_menu("load_game")

func _on_Settings_pressed():
	UI.set_menu("settings")

func _on_About_pressed():
	UI.set_menu("about")

func _on_Credits_pressed():
	UI.set_menu("credits")

func _on_Quit_pressed():
	Global.process_exit()

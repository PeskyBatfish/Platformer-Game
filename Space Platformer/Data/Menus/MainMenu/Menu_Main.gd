extends Menu

func _on_NewGame_pressed():
	UI.set_menu(UI.MENUS.new_game)

func _on_Load_pressed():
	UI.set_menu(UI.MENUS.load_game)

func _on_Settings_pressed():
	UI.set_menu(UI.MENUS.settings)

func _on_About_pressed():
	UI.set_menu(UI.MENUS.about)

func _on_Credits_pressed():
	UI.set_menu(UI.MENUS.credits)

func _on_Quit_pressed():
	Global.process_exit()

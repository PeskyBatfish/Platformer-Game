extends Menu

func _on_Resume_pressed():
	UI.set_menu(UI.MENUS.ingame)

func _on_Save_pressed():
	UI.set_menu(UI.MENUS.save_game)

func _on_Load_pressed():
	UI.set_menu(UI.MENUS.load_game)

func _on_Settings_pressed():
	UI.set_menu(UI.MENUS.settings)

func _on_Quit_pressed():
	UI.set_menu(UI.MENUS.quit_to_main_menu_confirmation)

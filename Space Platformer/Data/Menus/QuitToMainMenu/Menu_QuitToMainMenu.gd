extends Menu

func _on_Yes_pressed():
	Game.unload_level()
	UI.set_menu(UI.MENUS.main_menu)

func _on_No_pressed():
	UI.set_menu(UI.MENUS.pause_menu)

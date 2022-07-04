extends Menu

func _on_Yes_pressed():
	Game.unload_level()
	UI.set_menu("main_menu")

func _on_No_pressed():
	UI.pop_menu()

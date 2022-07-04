extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game_root = self
	UI.default_backdrop = $HUD/UI_Root/DefaultBackdrop
	UI.set_menu("main_menu")

	##### for debugging!
#	Game.load_level("Level_Demo")

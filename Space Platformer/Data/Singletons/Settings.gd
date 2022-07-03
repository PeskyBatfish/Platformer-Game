extends Node

# The settings can be accessed directly -- this has the advantage of
# super easy values access and update, HOWEVER we need to make sure
# we remember to call "save_to_disk()" after any setting update!
var json = {

	# (these are all empty at the moment)
	"display": {

	},
	"audio": {

	},
	"controls": {

	},
	"game": {

	}
}

###

func on_window_size_change():
	# todo
	pass

func _ready():
	get_tree().get_root().connect("size_changed", self, "on_window_size_change")

func save_to_disk():
	IO.save_json(json, "user://config.json")
func load_from_disk():
	json = IO.load_json("user://config.json")

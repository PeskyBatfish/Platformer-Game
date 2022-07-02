extends Node

# this is the runtime item database (dictionary object)
# that contains the current held items, quantities, params, etc.
var DATA = {}
func serialize():
	return DATA
func unserialize(dat):
	DATA = dat

func give_item(item):
	pass
func remove_item(item):
	pass

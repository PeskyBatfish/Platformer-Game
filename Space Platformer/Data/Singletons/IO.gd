extends Node

### - 1: internal file I/O handlers functions

var file_handle = null
func _open_handle(filename, ModeFlags):
	file_handle = File.new()
	if file_handle.file_exists(filename):
		file_handle.open(filename, ModeFlags)
		print("Opening file handle: ", filename)
		return true
	else:
		print("File not found: ", filename)
		file_handle = null
		return false
func _close_handle():
	if file_handle != null:
		file_handle.close()

### - 2: boilerplate functions

func save_variant(file_contents, filename):
	# todo
	pass
func save_json(file_contents, filename):
	# todo
	pass
func load_variant(filename):
	# todo
	pass
func load_json(filename):
	if _open_handle(filename, File.READ):
		var file_text = file_handle.get_as_text()
		_close_handle()
		return parse_json(file_text)

extends Node

# Internal methods (file I/O handling)
var file_handle = null
func _open_handle(filename, ModeFlags):
	file_handle = File.new()

	if ModeFlags == File.READ && !file_handle.file_exists(filename):
		print("File not found: ", filename)
		file_handle = null
		return false
	else:
		file_handle.open(filename, ModeFlags)
		if ModeFlags == File.READ:
			print("Loaded file: ", filename)
		elif ModeFlags == File.WRITE:
			print("Written file: ", filename)
		return true
func _close_handle():
	if file_handle != null:
		file_handle.close()

# Boilerplate

func load_json(filename):
	if _open_handle(filename, File.READ):
		var file_text = file_handle.get_as_text()
		_close_handle()
		return parse_json(file_text)
func save_json(file_contents, filename):
	if _open_handle(filename, File.WRITE):
		file_handle.store_string(JSON.print(file_contents))
		_close_handle()
		return true
	return false

func load_variant(filename):
	# todo
	pass
func save_variant(file_contents, filename):
	# todo
	pass

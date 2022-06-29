extends Node

func process_exit():
	get_tree().quit()

func save_to_file(filename, file_contents):
	# todo
	pass
func load_from_file(filename):
	var file = File.new()
	if file.file_exists(filename):
		file.open(filename, file.READ)
		var file_contents = file.get_as_text()
		file.close()
		return parse_json(file_contents)
	else:
		print("File not found: ",filename)

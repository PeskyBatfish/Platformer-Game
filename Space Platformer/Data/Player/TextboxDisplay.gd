extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file

var data = {}
var current_dialogue_id = 0
var current_object_id := ''
var dialogue_active = false


# Hide text box on initialization
func _ready():
	# Loads the dialogue from the .json file
	data = Global.load_from_file(dialogue_file)
	$Textbox.visible = false


## Call the 'play' function from NPC, grab the NPC's specific dialogue id
#func _NPC_start_dialogue(char_id):
#	if not dialogue_active:
#		turn_off_player()
#		$TextBox.visible = true
#		dialogue_active = true
#		current_character_id = str(char_id)
#		current_dialogue_id = -1
#		next_line()


func _object_start_speech(obj_id):
	if not dialogue_active:
		turn_off_player()
		$TextBox.visible = true
		dialogue_active = true
		current_object_id = str(obj_id)
		current_dialogue_id = -1
		next_line()


# Go to the next line when player presses the 'interact' key.
# If the last line has been reached, then the dialogue box closes.
func _input(event):
	if event.is_action_pressed("interact") and dialogue_active:
		next_line()

func next_line():
	var dialogues = data[current_object_id]
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogues):
		$Timer.start()
		$TextBox.visible = false
		return

	$TextBox/LabelName.text = dialogues[current_dialogue_id]['name']
	$TextBox/LabelMessage.text = dialogues[current_dialogue_id]['text']

# Create a small gap in time so the dialogue doesn't start again immediately
func _on_Timer_timeout():
	turn_on_player()
	dialogue_active = false


# Turn the player's movement on or off if in dialogue
func turn_on_player():
	var player = get_tree().get_root().find_node("Rose", true, false)
	if player:
		player.set_active(true)

func turn_off_player():
	var player = get_tree().get_root().find_node("Rose", true, false)
	if player:
		player.set_active(false)

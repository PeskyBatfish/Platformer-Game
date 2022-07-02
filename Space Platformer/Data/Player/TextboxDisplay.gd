extends CanvasLayer

export(String, FILE, "*.json") var dialogue_file = "res://Dialogue/dialogue.json"

var data = {}
var current_dialogue_id = 0
var current_object_id := ''
var dialogue_active = false


# Hide text box on initialization
func _ready():
	# Loads the dialogue from the .json file
	data = IO.load_json(dialogue_file)
	$Textbox.visible = false
	$Textbox/RectIcon/Sprite.scale *= 1.5
	Global.textbox = self

func start_dialogue(obj_id):
	if not dialogue_active:
		turn_off_player()
		$Textbox.visible = true
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
		$Textbox.visible = false
		return

	$Textbox/RectName/MarginContainer/RichTextLabel.text = dialogues[current_dialogue_id]['name']
	$Textbox/RectDialogue/MarginContainer/RichTextLabel.text = dialogues[current_dialogue_id]['text']
	$Textbox/RectIcon/Sprite.frame = dialogues[current_dialogue_id]['icon_id']

# Create a small gap in time so the dialogue doesn't start again immediately
func _on_Timer_timeout():
	turn_on_player()
	dialogue_active = false

# Turn the player's movement on or off if in dialogue
func turn_on_player():
	Global.player.set_active(true)

func turn_off_player():
	Global.player.set_active(false)

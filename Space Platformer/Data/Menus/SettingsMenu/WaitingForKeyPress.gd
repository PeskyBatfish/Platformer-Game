extends Menu

var action = null

func _ready():
	Global.config_keypress_dialog = self

func _input(event):
	if visible:
		if Input.is_action_just_pressed("ui_cancel"):
			pass # this is already handled by the internal UI input loop
		elif Input.is_action_just_released("ui_accept"):
			UI.pop_menu()
			get_tree().set_input_as_handled()
		else:
			if event is InputEventJoypadButton:
				$Backdrop/KeyText.text = Input.get_joy_button_string(event.button_index)
			elif event is InputEventKey && event.scancode != KEY_ESCAPE && event.scancode != KEY_ENTER:
				$Backdrop/KeyText.text = event.as_text()
			get_tree().set_input_as_handled()

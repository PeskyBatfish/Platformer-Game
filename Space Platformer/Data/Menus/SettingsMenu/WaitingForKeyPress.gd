extends Menu

var action = null
var keybind = null
var only_joypad = false

func set_bind(event):
	keybind = event
	if keybind == null:
		$Backdrop/KeyText.text = ""
	else:
		if event is InputEventJoypadButton:
			$Backdrop/KeyText.text = Input.get_joy_button_string(event.button_index)
		elif event is InputEventKey:
			$Backdrop/KeyText.text = event.as_text()

func _ready():
	Global.config_keypress_dialog = self

func _input(event):
	if visible:
		if Input.is_action_just_pressed("ui_cancel"):
			pass # this is already handled by the internal UI input loop
		elif Input.is_action_just_released("ui_accept"):
			UI.pop_menu()
			get_tree().set_input_as_handled()
			Settings.set_keybind_from_event(action, keybind)
		elif Input.is_action_just_released("keybinds_erase"):
			set_bind(null)
		else:
			if only_joypad && event is InputEventJoypadButton:
				set_bind(event)
			elif !only_joypad && event is InputEventKey && event.scancode != KEY_ESCAPE && event.scancode != KEY_ENTER && event.scancode != KEY_DELETE:
				set_bind(event)
			get_tree().set_input_as_handled()

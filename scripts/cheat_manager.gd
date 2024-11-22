extends Node

signal cheat_request_highlight
var cheat_code_started: bool = false
var input_history: String = ""
var cheat_codes: Array[String] = ["CHINOSHOW"]

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed() == false:
		var ev: InputEventKey = event as InputEventKey        
		input_history += ev.as_text()
		print("KEYCODE: ", ev.as_text())
	
		for code in cheat_codes:
			if code in input_history:
				cheat_request_highlight.emit()
				input_history = ""

		if input_history.length() > 25:
			input_history = ""

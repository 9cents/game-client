extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	var params = ScreenSwitcher._params
	$Label.text = params.text

# On button press, Exit the game
func _on_Button_pressed():
	get_tree().quit()

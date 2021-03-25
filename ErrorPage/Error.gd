extends Node

func _ready():
	var params = ScreenSwitcher._params
	$Label.text = params.text

func _on_Button_pressed():
	get_tree().quit()

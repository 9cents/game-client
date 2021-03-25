extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var params

# Called when the node enters the scene tree for the first time.

func _ready():
	params = ScreenSwitcher._params
	$Label.text = params["text"]

func _on_Button_button_up():
	params.erase("text")
	var next = params["next_scene"]
	params.erase("next_scene")
	ScreenSwitcher.change_scene( next, params)

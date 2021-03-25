extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Help_Button.connect("pressed", self,"Help")
	$Audio_Button.connect("pressed", self,"Audio")
	$Close_Button.connect("pressed", self,"Close")
	$Quit_Button.connect("pressed", self,"Quit")
	pass # Replace with function body.

#Change Scene to Help 
func Help():
	ScreenSwitcher.change_scene("res://World_Selection/Interface/Help.tscn")
	pass	

#Change Scene to AudioSetting
func Audio():
	ScreenSwitcher.change_scene("res://World_Selection/Interface/AudioSetting.tscn")
	pass

#Change Scene Back to Main Page
func Close():
	ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")
	pass

#Quit the Game
func Quit():
	get_tree().quit()
	pass
	


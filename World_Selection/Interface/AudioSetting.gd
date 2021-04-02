extends Control

func _ready():
	$Label/TextureButton.connect("pressed", self,"Back")
	pass

#On/Off the background music 
func _on_CheckButton_toggled(on):
	if on:
		Main._play()
	else:
		Main._stop()
	pass
	
	
#Upon Clicking on the button go back to Settings Page Scene 
func Back():
	ScreenSwitcher.change_scene("res://World_Selection/Interface/Settings Page.tscn")
	pass
	
#

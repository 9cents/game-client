extends Control


func _ready():
	$Label/TextureButton.connect("pressed", self,"Back")
	pass



func _on_CheckButton_toggled(on):
	if on:
		Main._play()
	else:
		Main._stop()
	pass
	
func Back():
	ScreenSwitcher.change_scene("res://World_Selection/Interface/Settings Page.tscn")
	pass
	
#

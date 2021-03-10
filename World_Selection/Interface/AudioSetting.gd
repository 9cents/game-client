extends Control


func _ready():
	$Label/Button.connect("pressed", self,"Back")
	pass



func _on_CheckButton_toggled(on):
	if on:
		Main._play()
	else:
		Main._stop()
	pass
	
func Back():
	get_tree().change_scene("res://World_Selection/Interface/Settings Page.tscn")
	pass
	
#

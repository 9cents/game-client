extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Audio_Button.connect("pressed", self,"Audio")
	$Back_Button.connect("pressed", self,"Back")
	$Quit_Button.connect("pressed", self,"Quit")
	pass # Replace with function body.

func Audio():
	get_tree().change_scene("res://World_Selection/Interface/AudioSetting.tscn")
	pass
	
	
func Back():
	get_tree().change_scene("res://World_Selection/Map/MainPage.tscn")
	
	pass
func Quit():
	get_tree().quit()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

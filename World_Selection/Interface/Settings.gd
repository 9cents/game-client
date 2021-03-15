extends Control

export var setting_scene: PackedScene
export var help_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	$Settings_Button.connect("pressed", self , "Settings")
	$Back_Button.connect("pressed", self, "Back")
	$Help_Button.connect("pressed", self , "Help")
	
	pass # Replace with function body.

func Settings():
	#get_tree().change_scene("res://Interface/Settings Page.tscn")
	ScreenSwitcher.change_scene_to(setting_scene)
	pass
	

func Back():
	#get_tree().change_scene("res://Map/Main Page.tscn")
	ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")
	pass

func Help():
	ScreenSwitcher.change_scene_to(help_scene)
	pass

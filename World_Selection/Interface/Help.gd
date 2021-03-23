extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var MainButtonScreen = get_node("ColorRect/MainButton/Main_Help")
onready var StoryButtonScreen = get_node("ColorRect/StoryButton/Story_Help")
onready var ChallengeButtonScreen = get_node("ColorRect/ChallengeButton/Challenge_Help")
onready var GameplayButtonScreen = get_node("ColorRect/GameplayButton/Gameplay_Help")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_MainButton_pressed():
	MainButtonScreen.show()
	StoryButtonScreen.hide()
	ChallengeButtonScreen.hide()
	GameplayButtonScreen.hide()
	pass # Replace with function body.

func _on_StoryButton_pressed():
	MainButtonScreen.hide()
	StoryButtonScreen.show()
	ChallengeButtonScreen.hide()
	GameplayButtonScreen.hide()
	pass # Replace with function body.
	
func _on_ChallengeButton_pressed():
	MainButtonScreen.hide()
	StoryButtonScreen.hide()
	ChallengeButtonScreen.show()
	GameplayButtonScreen.hide()
	pass # Replace with function body.
	
func _on_GameplayButton_pressed():
	MainButtonScreen.hide()
	StoryButtonScreen.hide()
	ChallengeButtonScreen.hide()
	GameplayButtonScreen.show()
	pass # Replace with function body.
	
	
func _on_CloseButton_pressed():
	ScreenSwitcher.change_scene("res://World_Selection/Interface/Settings Page.tscn")
	pass # Replace with function body.

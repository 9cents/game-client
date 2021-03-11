extends CanvasLayer

signal leaderboard

onready var enter_container = get_node("ColorRect/ScrollBar/EnterUsernameContainer")
onready var username = get_node("ColorRect/ScrollBar/EnterUsernameContainer/EnteredUsername")
onready var dungeon_container = get_node("ColorRect/ScrollBar/DungeonFoundContainer")

onready var confirm_button = get_node("ColorRect/ScrollBar/EnterUsernameContainer/ConfirmButton")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


func _on_ConfirmButton_pressed():
	print("Searching for player")
	
	if username.get_text() == "":
		print("Please enter a valid username")
		
	else:
		var found = false	
		confirm_button.disabled = true
		#HTTP request to verify if the user exist and has created an account
		#Return boolean variable and navigate to next scene if true
		if found == true:
			enter_container.hide()
			dungeon_container.show()
			
		else:
			username.clear()
			confirm_button.disabled = false
			print("User not found or has no dungeon created")


func _on_EnterDungeonButton_pressed():
	print("Entering user created dungeon")
	#Change scene to dungeon
	get_tree().change_scene("res://Gameplay/Top.tscn")
	pass


func _on_CloseButton_toggled(button_pressed):
	get_tree().change_scene("res://World_Selection/Map/ChallengeMode.tscn")
	pass # Replace with function body.

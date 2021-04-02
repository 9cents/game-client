extends CanvasLayer

signal leaderboard

onready var enter_container = get_node("ColorRect/ScrollBar/EnterUsernameContainer")
onready var username = get_node("ColorRect/ScrollBar/EnterUsernameContainer/EnteredUsername")
onready var dungeon_container = get_node("ColorRect/ScrollBar/DungeonFoundContainer")

onready var confirm_button = get_node("ColorRect/ScrollBar/EnterUsernameContainer/ConfirmButton")

var qns = []
var player_name = ''
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Authentication to check for available dungeon
func _on_ConfirmButton_pressed():
	print("Searching for player")
	
	if username.get_text() == "":
		$ColorRect/ErrorMessage.text = "Please enter a valid username"
		
	else:
		var found = false	
		confirm_button.disabled = true
		$ColorRect/ErrorMessage.text = "searching for dungeon ..."
		
		Api.connect("call_done", self, "challenge_data_done")
		Api.get_challenge_data({"player_name": username.get_text()})
		#HTTP request to verify if the user exist and has created an account
		#Return boolean variable and navigate to next scene if true
		player_name = username.get_text()

#On Enter button press, change to the user created gameplay scene
func _on_EnterDungeonButton_pressed():
	$ColorRect/ErrorMessage.text = "Entering user created dungeon"
	#Change scene to dungeon
	ScreenSwitcher.change_scene("res://splashscreen/splashscreen.tscn", {"world": "challenge", "tower": username.get_text(), "qns": qns})
	pass

#Change scene back to challenge page 
func _on_CloseButton_toggled(button_pressed):
	ScreenSwitcher.change_scene("res://World_Selection/Map/ChallengeMode.tscn")
	pass # Replace with function body.

#Display text if user's dungeon is not found
#param result store the dungeon info 
func challenge_data_done(result):
	if result == []:
		confirm_button.disabled = false
		$ColorRect/ErrorMessage.text = 'User not found or has no dungeon created'
	else:
		qns = result
		$ColorRect/ErrorMessage.text = ''
		enter_container.hide()
		dungeon_container.show()

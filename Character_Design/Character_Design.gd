extends Control

export var reference_path = ""
export(bool) var start_focused = false

var char_type = null

func _ready():
	$AnimatedSprite.play()

#On button press, change character to knight
func _on_btn_Warrior_pressed():
	$AnimatedSprite.animation = "knight"
	char_type = "knight"
	pass # Replace with function body.

#On button press, change character to mage
func _on_btn_mage_pressed():
	$AnimatedSprite.animation = "mage"
	char_type = "mage"
	pass # Replace with function body.

#On button press, change character to ninja
func _on_btn_assasin_pressed():
	$AnimatedSprite.animation = "ninja"
	char_type = "ninja"
	pass # Replace with function body.

#On button press, confirm character and update to server 
func _on_btn_Confirm_pressed():
	var body = {
			"character": char_type,
			"conditions": {
				"player_name": Main.username
			}
		}
	Api.connect("call_done", self, "update_char_done")
	Api.update_char(body)
	pass # Replace with function body.

#Switch to MainPage Scene after character selection
func update_char_done(result):
	print(result)
	if "error" in result:
		$ErrorMessage.text = "Request unsuccessfull, try again!"
	else:
		Main.char_name = char_type
		ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")

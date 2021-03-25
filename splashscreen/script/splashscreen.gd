extends Control

var params = ScreenSwitcher._params

func _ready():
	$Timer.start()
	if !("qns" in params):
		Api.connect("call_done", self, "get_qns_done")
		Api.get_qns_list({"tower":params["tower"]})

#Switch to the game scene
func go_title_screen():
	if "qns" in params:
		ScreenSwitcher.change_scene("res://Gameplay/Main.tscn", params)
	$Timer.start()

#Play the Splash screen Animation
func _on_AnimationPlayer_animation_finished(anim_name):
	go_title_screen()
	pass # Replace with function body.

#Set the timer for the splash screen
func _on_Timer_timeout():
	go_title_screen()
	$Timer.stop()

#Get the question and level 
func get_qns_done(result):
	params["qns"] = result["data"]
	params["level"] = result["level_name"]

extends Control

var params = ScreenSwitcher._params

func _ready():
	$Timer.start()
	if !("qns" in params):
		Api.connect("call_done", self, "get_qns_done")
		Api.get_qns_list({"tower":params["tower"]})

func go_title_screen():
	if "qns" in params:
		ScreenSwitcher.change_scene("res://Gameplay/Main.tscn", params)
	$Timer.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	go_title_screen()
	pass # Replace with function body.


func _on_Timer_timeout():
	go_title_screen()
	$Timer.stop()
	
func get_qns_done(result):
	params["qns"] = result["data"]
	params["level"] = result["level_name"]

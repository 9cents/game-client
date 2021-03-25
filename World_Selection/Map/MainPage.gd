extends Node2D

func _ready():
	Api.connect("call_done", self, "get_assignment_done")
	Api.get_assignment_qns({})

func get_assignment_done(result):
	if "error" in result:
		var params = {}
		params["text"] = "ERROR"
		ScreenSwitcher.change_scene("res://TransitionScreen/TransitionScreen.tscn", params)
		return
	if result["lock"]:
		remove_child($Assignment)
		return
	$Assignment.start("assignment", 0, result["data"])


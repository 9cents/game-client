extends Node2D

# Called when the node enters the scene tree for the first time.
#HTTP request to get world name
func _ready():
	Api.connect("call_done", self, "get_world_name_done")
	Api.get_world_name({})
	
	pass # Replace with function body.

#Display World name
func get_world_name_done(result):
	$World1.start(result[0], 0)
	$World2.start(result[1], 1)
	$World3.start(result[2], 2)
	
	$World1/Label.text = result[0]
	$World2/Label.text = result[1]
	$World3/Label.text = result[2]


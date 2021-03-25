extends Node

var world_id
var current_world = ''

# Called when the node enters the scene tree for the first time.
func _ready():
	current_world = ScreenSwitcher.get_param("world")
	world_id = ScreenSwitcher.get_param("world_id")
	$CanvasLayer/Label.text = current_world
	
	Api.connect("call_done", self, "get_tower_name_done")
	Api.get_tower_name({})
	#HTTP Request to get the tower name
	
#Display Tower name
func get_tower_name_done(result):
	$Tower1.start(current_world, world_id, result)
	$Tower2.start(current_world, world_id, result)
	$Tower3.start(current_world, world_id,result)
	
	$Tower1/Label.text = result[world_id][0]
	$Tower2/Label.text = result[world_id][1]
	$Tower3/Label.text = result[world_id][2]

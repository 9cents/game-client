extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var current_world = ScreenSwitcher.get_param("world")
	$Tower1.start(current_world)
	$Tower2.start(current_world)
	$Tower3.start(current_world)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

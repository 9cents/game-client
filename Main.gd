extends Control

# Declare member variables here. Examples:
var username
var char_name
var user_id



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#Off the background music
func _stop():
	$AudioStreamPlayer.stop()
	pass

#On the background music
func _play():
	$AudioStreamPlayer.play()
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

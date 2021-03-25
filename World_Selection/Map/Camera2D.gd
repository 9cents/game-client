extends Camera2D

#Lowest value for the zoom_level
export var min_zoom := 1.0
#Highest value for the zoom_level
export var max_zoom := 2.0
#Controlling the increment and decrement of zoom level on each click or scroll
export var zoom_factor := 0.1
#zoom's tween animation time
export var zoom_time := 0.2

# The camera's target zoom level.
var zoom_level := 1.0 setget _set_zoom_level

# We store a reference to the scene's tween node.
onready var tween: Tween = $Tween

#Set the range of the value between min_zoom and max_zoom
func _set_zoom_level(value: float) -> void:
	zoom_level = clamp(value, min_zoom, max_zoom)
	tween.interpolate_property(
		self,"zoom",zoom,Vector2(zoom_level, zoom_level),zoom_time,tween.TRANS_SINE,tween.EASE_OUT)
	tween.start()
	
#Adjust the zoom increment and decrement upon each click or scroll 
func _unhandled_input(event):
	if event.is_action_pressed("zoom_in"):
		_set_zoom_level(zoom_level - zoom_factor)
	if event.is_action_pressed("zoom_out"):
		_set_zoom_level(zoom_level + zoom_factor)

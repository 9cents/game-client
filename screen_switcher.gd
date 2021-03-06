# scene_switcher.gd
extends Node

# Private variable
var _params = null

# Call this instead to be able to provide arguments to the next scene
func change_scene(next_scene, params=null):
	_params = params
	get_tree().change_scene(next_scene)
#	print(_params)

func change_scene_to(next_scene, params=null):
	_params = params
	get_tree().change_scene_to(next_scene)
#	print(_params)

# In the newly opened scene, you can get the parameters by name
func get_param(name):
	if _params != null and _params.has(name):
		return _params[name]
	return null

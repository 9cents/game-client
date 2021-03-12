tool
extends Area2D

export var next_scene: PackedScene
onready var animation_player: AnimationPlayer = $AnimationPlayer

var world_name

func start(worldname):
	world_name = worldname

func _on_Portal2D_body_entered(body):
	teleport()
	
func _get_configuration_warning() -> String:
	return "The next scene property can't be empty" if not next_scene else " "


func teleport() -> void:
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene_to(next_scene, {'world': world_name})
	

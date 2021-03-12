tool
extends Area2D

export var next_scene: PackedScene
onready var animation_player: AnimationPlayer = $AnimationPlayer

var world_name

func start(worldname):
	world_name = worldname

func _on_Tower1_body_entered(body):
	teleport('tower1')
	
func _on_Tower2_body_entered(body):
	teleport('tower2')

func _on_Tower3_body_entered(body):
	teleport('tower3')

func _on_Assignment_body_entered(body):
	teleport('assignment')


func teleport(tower_name) -> void:
	#animation_player.play("fade_in")
	#yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene_to(next_scene, {'world': world_name, 'tower': tower_name})


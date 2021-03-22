tool
extends Area2D

export var next_scene: PackedScene
onready var animation_player: AnimationPlayer = $AnimationPlayer

var world_name
var tower_names = []
var world_id

func start(worldname, worldid, result):
	world_name = worldname
	tower_names = result
	world_id = worldid

func _on_Tower1_body_entered(body):
	teleport(tower_names[world_id][0])
	
func _on_Tower2_body_entered(body):
	teleport(tower_names[world_id][1])

func _on_Tower3_body_entered(body):
	teleport(tower_names[world_id][2])

func teleport(tower) -> void:
	ScreenSwitcher.change_scene_to(next_scene, {'world': world_name, 'tower': tower})


tool
extends Area2D

export var next_scene: PackedScene
onready var animation_player: AnimationPlayer = $AnimationPlayer

var world_name
var world_id
var q

#On start, get the world name and id 
func start(worldname, id, qns=null):
	world_name = worldname
	world_id = id
	if qns:
		q = qns

func _on_Portal2D_body_entered(body):
	teleport()
	
func _on_Assignment_body_entered(body):
	teleport()


#Entered Portal,Play Animation,Change Scene
func teleport() -> void:
	if world_name != "assignment":
		animation_player.play("fade_in")
		yield(animation_player, "animation_finished")
		ScreenSwitcher.change_scene_to(next_scene, {'world': world_name, 'world_id': world_id})
		return
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene_to(next_scene, {'world': world_name, 'world_id': world_id, 'qns': q, 'tower':''})

tool
extends Area2D

export var next_scene: PackedScene
onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_Tower1_body_entered(body):
	teleport()
	
func _on_Tower2_body_entered(body):
	teleport()

func _on_Tower3_body_entered(body):
	teleport()

func _on_Assignment_body_entered(body):
	teleport()


func teleport() -> void:
	#animation_player.play("fade_in")
	#yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene_to(next_scene)


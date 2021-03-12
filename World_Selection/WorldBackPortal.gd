tool
extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_BackPortal_body_entered(body):
	teleport()
	

func teleport() -> void:
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene("res://World_Selection/Map/Story Mode.tscn")
	




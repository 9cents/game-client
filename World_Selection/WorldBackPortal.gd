tool
extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_BackPortal_body_entered(body):
	teleport()
	
#Entered Portal,Play Animation,Change Scene
func teleport() -> void:
	animation_player.play("fade_in")
	animation_player.playback_speed = 2.0
	yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene("res://World_Selection/Map/Story Mode.tscn")
	




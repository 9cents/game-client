tool
extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_Portal2D_body_entered(body):
	teleport()
	
	
#Entered Portal,Play Animation,Change Scene
func teleport() -> void:
	animation_player.play("fade_in")
	yield(animation_player, "animation_finished")
	ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")
	

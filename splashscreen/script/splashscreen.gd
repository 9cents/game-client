extends Control

func _input(event):
	if(event is InputEventKey):
		go_title_screen()

func go_title_screen():
	ScreenSwitcher.change_scene("res://Gameplay/Top.tscn", ScreenSwitcher._params)

func _on_AnimationPlayer_animation_finished(anim_name):
	go_title_screen()
	pass # Replace with function body.

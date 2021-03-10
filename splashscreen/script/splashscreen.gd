extends Control

func _input(event):
	if(event is InputEventKey):
		go_title_screen()

func go_title_screen():
	get_tree().change_scene("res://Gameplay/Top.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	go_title_screen()
	pass # Replace with function body.

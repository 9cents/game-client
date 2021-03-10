extends Control


func _ready():
	#Settings_Button.connect("pressed", self , "Settings")
	#$Back_Button.connect("pressed", self, "Back")

	pass # Replace with function body.

func warrior():
	get_tree().change_scene("res://Interface/CharacterDesign_warrior.tscn")
	#get_tree().change_scene_to(CharacterDesign_warrior)
	pass
	
func mage():
	get_tree().change_scene("res://Interface/CharacterDesign_mage.tscn")
	#get_tree().change_scene_to(CharacterDesign_mage)
	pass
	
func assasin():
	get_tree().change_scene("res://Interface/CharacterDesign_assasin.tscn")
	#get_tree().change_scene_to(CharacterDesign_assasin)
	pass
	
	
func Back():
	#get_tree().change_scene_to(back_scene)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

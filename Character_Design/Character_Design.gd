extends Control

export var reference_path = ""
export(bool) var start_focused = false

func _ready():
	$AnimatedSprite.play()
	


func _on_btn_Warrior_pressed():
	$AnimatedSprite.animation = "knight"
	pass # Replace with function body.


func _on_btn_mage_pressed():
	$AnimatedSprite.animation = "mage"
	pass # Replace with function body.


func _on_btn_assasin_pressed():
	$AnimatedSprite.animation = "ninja"
	pass # Replace with function body.

extends Button
export(bool) var start_focused = false


# Called when the node enters the scene tree for the first time.
func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered",self,"on_Button_mouse_entered")
	connect("pressed",self,"on_Button_Pressed")

func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	pass

func _on_Mage_hide():
	$Mage.hide()


func _on_Assasin_hide():
	$KinematicBody2D/Assasin.hide()
	pass # Replace with function body.

extends Button

export var reference_path = ""
export(bool) var start_focused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if(start_focused):
		grab_focus()
		
	connect("mouse_entered",self,"on_Button_mouse_entered")
	connect("pressed",self,"on_Button_Pressed")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_up"):
		$KinematicBody2D/Assasin.visible = !$KinematicBody2D/Assasin.visible
	elif Input.is_action_just_pressed("ui_down"):
		$KinematicBody2D/Assasin.visible = !$KinematicBody2D/Assasin.visible
func _on_Button_mouse_entered():
	grab_focus()
	
func _on_Button_Pressed():
	$KinematicBody2D/Assasin.visible = !$KinematicBody2D/Assasin.visible
	


func _on_Warrior_hide():
	$KinematicBody2D/Warrior.hide()
	pass # Replace with function body.

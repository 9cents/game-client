extends Control

onready var login_screen = get_node("Background/LoginScreen")
onready var create_account_screen = get_node("Background/CreateAccount")

onready var create_email_input = get_node("Background/CreateAccount/Email")
onready var create_username_input = get_node("Background/CreateAccount/Username")
onready var create_password_input = get_node("Background/CreateAccount/Password")
onready var create_passwordrep_input = get_node("Background/CreateAccount/ConfirmPassword")

onready var confirm_button = get_node("Background/CreateAccount/Confirm")
onready var back_button = get_node("Background/CreateAccount/Back")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoginButton_pressed():
	pass # Replace with function body.


func _on_CreateAccountButton_pressed():
	login_screen.hide()
	create_account_screen.show()
	create_email_input.clear()
	create_username_input.clear()
	create_password_input.clear()
	create_passwordrep_input.clear()

func _on_BackButton_pressed():
	login_screen.show()
	create_account_screen.hide()


func _on_ConfirmButton_pressed():
	
	if create_username_input.get_text() == "":
		print("Please enter a valid username")
		
	elif create_password_input.get_text() == "":
		print("Please enter a valid password")	
		
	elif create_password_input.get_text().length() <= 6:
		print("Password must contain at least 7 characters")		
		
	elif create_passwordrep_input.get_text() != create_password_input.get_text():
		print("Password do not match")
	
#	else:
#		confirm_button.disabled = true
#		back_button.disabled = true
#		var username = create_username_input.get_text()
#		var password = create_password_input.get_text()
#		print("Attemping to login")
#		Gateway.ConnectToServer(username, password)
		

		

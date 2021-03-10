extends Control

onready var login_screen = get_node("Background/LoginScreen")
onready var create_account_screen = get_node("Background/CreateAccount")
onready var login_user = get_node("Background/LoginScreen/Username")
onready var login_password = get_node("Background/LoginScreen/Password")
onready var create_email_input = get_node("Background/CreateAccount/Email")
onready var create_username_input = get_node("Background/CreateAccount/Username")
onready var create_password_input = get_node("Background/CreateAccount/Password")
onready var create_passwordrep_input = get_node("Background/CreateAccount/ConfirmPassword")

onready var login_button = get_node("Background/LoginScreen/LoginButton")
onready var create_button = get_node("Background/LoginScreen/CreateAccountButton")
onready var confirm_button = get_node("Background/CreateAccount/ConfirmButton")
onready var back_button = get_node("Background/CreateAccount/BackButton")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LoginButton_pressed():
	if login_user.get_text() == "":
		print("Please enter a valid username")
		
	elif login_password.get_text() == "":
		print("Please enter a valid password")	
	
	else:
		var login = false
		login_button.disabled = true
		create_button.disabled = true
		var username = login_user.get_text()
		var password = login_password.get_text()
		print("Attemping to login")
		#Send username and password to the databse
		#HTTP request to verify the information to database
		#Change the boolean variable login to true then switch to game scene
		if login == true:
			get_tree().change_scene("res://World_Selection/Map/MainPage.tscn")
			pass #Switch to scene
			
		else:
			print("Unsuccessful login")
			pass


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
	login_user.clear()
	login_password.clear()


func _on_ConfirmButton_pressed():
	
	if create_username_input.get_text() == "":
		print("Please enter a valid username")
		
	elif create_password_input.get_text() == "":
		print("Please enter a valid password")	
		
	elif create_password_input.get_text().length() <= 6:
		print("Password must contain at least 7 characters")		
		
	elif create_passwordrep_input.get_text() != create_password_input.get_text():
		print("Password do not match")
	
	else:
		var created = false
		confirm_button.disabled = true
		back_button.disabled = true
		var email = create_email_input.get_text()
		var username = create_username_input.get_text()
		var password = create_password_input.get_text()
		print("Attemping to create account")
		#Send email, username and password to the databse
		#HTTP update to database
		if created == true:
			print("Account successfully created")
			
		else:
			print("Unsuccessful account creation")

		

		

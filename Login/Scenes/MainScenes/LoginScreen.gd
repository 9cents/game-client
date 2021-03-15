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
	Api.connect("call_done", self, "request_finished")
	pass # Replace with function body.

func _on_LoginButton_pressed():
	if login_user.get_text() == "":
		$ErrorMessages.text = "Please enter a valid username"
		
	elif login_password.get_text() == "":
		$ErrorMessages.text = "Please enter a valid password"
	
	else:
		var login = false
		login_button.disabled = true
		create_button.disabled = true
		var username = login_user.get_text()
		var password = login_password.get_text()
		$ErrorMessages.text = "Attemping to login..."
		Main.username = username
		
		Api.login({"name": username, "password": password})

func _on_CreateAccountButton_pressed():
	login_screen.hide()
	create_account_screen.show()
	create_email_input.clear()
	create_username_input.clear()
	create_password_input.clear()
	create_passwordrep_input.clear()
	$ErrorMessages.text = ''

func _on_BackButton_pressed():
	login_screen.show()
	create_account_screen.hide()
	login_user.clear()
	login_password.clear()
	$ErrorMessages.text = ''


func _on_ConfirmButton_pressed():
	
	if create_username_input.get_text() == "":
		$ErrorMessages.text = ("Please enter a valid username")
		
	elif create_password_input.get_text() == "":
		$ErrorMessages.text = ("Please enter a valid password")	
		
	elif create_password_input.get_text().length() <= 6:
		$ErrorMessages.text = ("Password must contain at least 7 characters")		
		
	elif create_passwordrep_input.get_text() != create_password_input.get_text():
		$ErrorMessages.text = ("Password do not match")
	
	else:
		var created = false
		# confirm_button.disabled = true
		# back_button.disabled = true
		var email = create_email_input.get_text()
		var username = create_username_input.get_text()
		var password = create_password_input.get_text()
		$ErrorMessages.text =("Attemping to create account")
		Api.signin({"name": username, "password": password})

func request_finished(response):
	if login_screen.is_visible_in_tree():
		if "error" in response:
			login_button.disabled = false
			create_button.disabled = false
			$ErrorMessages.text = "Unsuccessful login"
		else:
			Main.char_name = response["data"]["character"]
			Main.user_id = response["data"]["player_id"]
			
			if Main.char_name == null:
				ScreenSwitcher.change_scene("res://Character_Design/Character_Design.tscn")
			else:
				ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")
	elif create_account_screen.is_visible_in_tree():
		if "error" in response:
			$ErrorMessages.text = "Unsuccessful account creation"
		else:
			$ErrorMessages.text = "Account successfully created"
			login_screen.show()
			create_account_screen.hide()
			login_user.clear()
			login_password.clear()

		

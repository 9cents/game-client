extends Node
#
#var network = NetworkedMultiplayerENet.new()
#var ip = "127.0.0.1"
#var port = 1910
#
#var username
#var password
#
#func _ready():
#	pass
#
#func _process(delta):pass
#
#func ConnectToServer(_username, _password):
#	network = NetworkedMultiplayerENet.new()
#	gateway_api = MultiplayerAPI.new()
#	username = _username
#	password = _password
#	network.create_client(ip, port)
#	set_custom_multiplayer(gateway_api)
#	custom_multiplayer.set_root_node(self)
#	custom_multiplaer.set_network_peer(network)
#
#	network.connect("connection_failed", self, "_OnConnectionFailed")
#	network.connect("connection_succeeded", self, "_OnConnectionSucceeded")
#
#func _OnConnectionFailed():
#	print("Failed to connect to login server")
#	get_node("../Background/LoginScreen").log_button.disabled = false
#
#func _OnConnectionSucceeded():
#	print("Successfully connected to login server")
#	RequestLogin()
#
#func RequestLogin():
#	print("Connecting to gateway to request login")
#	rpc_id(1, "LoginRequest", username, password)
#	username = ""
#	password = ""
#
#remote func ReturnLoginRequest(results):
#	print("Results received")
#	if results == true:
#		GameServer.ConnectToServer()
#		get_node("../Background/LoginScreen").queue_free()
#
#	else:
#		print("Please provide a correct username and password")
#		get_node("../Background/LoginScreen").log_button.disabled = false
#
#	network.disconnect("connection_failed", self, "_OnConnectionFailed")
#	network.disconnect("connection_succeeded", self, "_OnConnectionSucceeded")

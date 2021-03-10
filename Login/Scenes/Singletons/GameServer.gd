extends Node

#var ip = "145.
var port = 1909

func _ready():
	pass
	
func ConnectToServer():
	network.create_cilent(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "_OnConnectionSucceeded")
	
func _OnConnectionFailed():
	print("Failed to connect to game server")
	
func _OnConnectionSucceeded():
	print("Successfully connected to game server")
	

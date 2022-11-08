extends Control

func _ready():
	var _connect = get_tree().connect("network_peer_connected", self, "_player_connected")


func _on_Host_pressed():
	var net = NetworkedMultiplayerENet.new()	# Set up networking
	net.create_server(13458, 4095)				# This Godot instance will host the game (i.e., be the server). It will connect on TCP/UDP port 13458, and it can host 4095 possible connections
	get_tree().set_network_peer(net)
	Global.which_player = 1						# The hosting instance will control player 1 
	$Label.text = "Hosting"
	$Host.hide()
	$Join.hide()

func _on_Join_pressed():
	var net = NetworkedMultiplayerENet.new()
	net.create_client("127.0.0.1", 13458)		# This Godot instance will join an existing game. 127.0.0.1 (localhost) means to connect to this computer on port 13458
	get_tree().set_network_peer(net)
	Global.which_player = 2						# Control player 2
	$Label.text = "Joining"
	$Host.hide()
	$Join.hide()

func _player_connected(id):						# When the connection has successfully been made, load the Game scene and hide the lobby
	Global.player2id = id
	var game = preload("res://Game.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()

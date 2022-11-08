extends Spatial

onready var player1pos = $Player1Pos								# the starting position for player 1
onready var player2pos = $Player2Pos								# starting position for player 2
onready var controlled = load("res://Player/Player.gd")				# the "active" player's script
onready var passive = load("res://Player/Player_passive.gd")		# the network-controlled player's sccript

func _ready():
	var player1 = preload("res://Player/Player.tscn").instance()	# instance player 1
	player1.name = "Player1"
	player1.set_network_master(get_tree().get_network_unique_id())	# Set up the ability for the player to communicate over the network
	player1.global_transform = player1pos.global_transform			# set the initial position
	player1.get_node("Mesh").get_surface_material(0).albedo_color = Color8(34,139,230)	# set player1's color to blue
	if Global.which_player == 1:									# If this window is hosting, control player 1
		player1.script = controlled
	else:
		player1.script = passive
	add_child(player1)												# Add player 1 to the game
	
	var player2 = preload("res://Player/Player.tscn").instance()
	player2.name = "Player2"
	player2.set_network_master(Global.player2id)
	player2.global_transform = player2pos.global_transform
	player2.get_node("Mesh").get_surface_material(0).albedo_color = Color8(250,82,82)	# set the color to red
	if Global.which_player == 2:
		player2.script = controlled
	else:
		player2.script = passive
	add_child(player2)

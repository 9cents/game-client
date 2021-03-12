extends Node

var current_scene = null

export (PackedScene) var Main
export (PackedScene) var Leaderboard

func _ready():
	print('aaaa', ScreenSwitcher.get_param('tower'), ScreenSwitcher.get_param('world'))
	play_game('t', 'math', 'limit')

func play_game(type, world, tower):
	current_scene = Main.instance()
	add_child(current_scene)
	current_scene.start("http://www.mocky.io/v2/5185415ba171ea3a00704eed")
	current_scene.connect('end', self, "level_completed")

func level_completed(type, win:bool):
	if win: level_completed_win(type)
	else: level_completed_lose(type)

func level_completed_win(type):
	if type == 'tower':
		current_scene = Leaderboard.instance()
	elif type == 'dungeon':
		current_scene = Leaderboard.instance()
	elif type == 'pvp':
		current_scene = Leaderboard.instance()
	add_child(current_scene)
	print("win")

func level_completed_lose(type):
	if type == 'tower':
		current_scene = Leaderboard.instance()
	elif type == 'dungeon':
		current_scene = Leaderboard.instance()
	elif type == 'pvp':
		current_scene = Leaderboard.instance()
	add_child(current_scene)
	print("lose")

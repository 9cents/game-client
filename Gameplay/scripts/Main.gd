extends Node

var params = {}
var questions

var q
var health = 40
var enemies = []
var curr_q = 0

# SIGNALS
signal end(value, other_value)

# SCENES
export (PackedScene) var Enemy

func _ready():
	randomize()
	params= ScreenSwitcher._params
	$TextureRect.margin_top = 0
	$TextureRect.margin_bottom = OS.window_size.y*0.25
	$TextureRect.margin_right =  OS.window_size.x
	$TextureRect.margin_left = 0
	
	$Label.margin_top = 50
	$Label.margin_bottom = OS.window_size.y*0.4 - 30
	$Label.margin_right =  OS.window_size.x - 30
	$Label.margin_left = 30
	
	$LevelLabel.text = "LV. 5 - WAVE " + str(curr_q+1)
	
	start()

func start():
	print('start')
	questions = params["qns"]
	q = questions[0]
	
	$Player.start($StartPosition.position)
	$ProgressBar.max_value = health
	$ProgressBar.value = health
	handle_respawn()

func create_enemy(id):
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.start(id)
	enemy.connect('hit', self, "get_hit")
	enemies.append(enemy)
	
func get_hit(id):
	if id == q["correct"]:
		handle_despawn()
		handle_respawn()
	else:
		health -= 10
		$ProgressBar.value=health
		handle_health()

func handle_despawn():
	for e in range(len(enemies)):
		var enemy = enemies.pop_back()
		enemy.end()

func handle_respawn():
	if curr_q == len(questions):
		handle_despawn()
		$EndTimer.start()
		return
	q = questions[curr_q]
	change_label(q)
	curr_q += 1
	$Player.make_collidable(false)
	$StartTimer.start()
	$LevelLabel.text = "WAVE " + str(curr_q)
	print('timer started')
	for i in range(len(q["answers"])):
		create_enemy(i)
	
func handle_health():
	if health<= 0:
		handle_despawn()
		params['win'] = false
		if params["world"] == "challenge":
			ScreenSwitcher.change_scene("res://World_Selection/Map/ChallengeMode.tscn", params)
		ScreenSwitcher.change_scene("res://World_Selection/Map/Story Mode.tscn", params)

func change_label(question):
	var str_q = question["question_body"] + "\n"
	for i in range(len(question["answers"])):
		str_q += ' \n '+char(65+i)+'. '+question['answers'][i]
	$Label.text= str_q
		
func _on_StartTimer_timeout():
	$Player.make_collidable(true)
	for e in range(len(enemies)):
		var enemy = enemies[e]
		enemy.start_moving()
	$StartTimer.stop()


func _on_Player_freeze():
	for e in range(len(enemies)):
		var enemy = enemies[e]
		enemy.freeze()


func _on_Player_defreeze():
	for e in range(len(enemies)):
		var enemy = enemies[e]
		enemy.move()


func _on_EndTimer_timeout():
	params['win'] = true
	if params["world"] == "challenge":
		params.erase("qns")
		ScreenSwitcher.change_scene("res://World_Selection/Map/ChallengeMode.tscn", params)

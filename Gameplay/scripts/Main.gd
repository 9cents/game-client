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
var label_text = "WAVE "
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
	if "level" in params:
		label_text = params["level"]+" - WAVE "
	$LevelLabel.text = label_text + str(curr_q+1)
	
	start()

#Show the Health bar and questions
func start():
	questions = params["qns"]
	q = questions[0]
	
	$Player.start($StartPosition.position)
	$ProgressBar.max_value = health
	$ProgressBar.value = health
	handle_respawn()

#Spawn the enermy
func create_enemy(id):
	var enemy = Enemy.instance()
	add_child(enemy)
	enemy.start(id)
	enemy.connect('hit', self, "get_hit")
	enemies.append(enemy)
	
#Get the correct answer from the server and compare with the chosen answer
func get_hit(id):
	var data = {"question_body": q["question_body"], "answer_body": q["answers"][id]}
	Api.send_response(data)
	if id == q["correct"]:
		handle_despawn()
		handle_respawn()
	else:
		health -= 10
		$ProgressBar.value=health
		handle_health()

#Despawn the enermy upon collision
func handle_despawn():
	for e in range(len(enemies)):
		var enemy = enemies.pop_back()
		enemy.end()

#Spawn new enermy upon correct answer
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
	$LevelLabel.text = label_text + str(curr_q)
	for i in range(len(q["answers"])):
		create_enemy(i)

#When the health bar reaches 0, display lose text screen
func handle_health():
	if health<= 0:
		handle_despawn()
		params['win'] = false
		params.erase("qns")
		params["text"] = "You Lose :( Keep trying!\n" + params["world"] + "-" + params["tower"]
		if params["world"] == "challenge":
			params["next_scene"] = "res://World_Selection/Map/ChallengeMode.tscn"
		elif params["world"] == "assignment":
			params["text"] = "You Lose :( Keep trying!\n" + params["world"] + " dungeon"
			params["next_scene"] = "res://World_Selection/Map/MainPage.tscn"
		else:
			var body = {"tower": params["tower"], "body":{}}
			Api.lose_response(body)
			params["next_scene"] = "res://World_Selection/Map/Story Mode.tscn"	
		ScreenSwitcher.change_scene("res://TransitionScreen/TransitionScreen.tscn", params)

#Change questions after each wave
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

#Complete all the question,display win text screen
func _on_EndTimer_timeout():
	params['win'] = true
	params.erase("qns")
	params["text"] = "Congratulation! You win!\n" + params["world"] + "-" + params["tower"]
	if params["world"] == "challenge":
		params["next_scene"] = "res://World_Selection/Map/ChallengeMode.tscn"
	elif params["world"] == "assignment":
		params["text"] = "Congratulation! You win!\n" + params["world"] + " dungeon"
		params["next_scene"] = "res://World_Selection/Map/MainPage.tscn"
	else:
		var body = {"tower": params["tower"], "body":{}}
		Api.win_response(body)
		params["next_scene"] = "res://World_Selection/Map/Story Mode.tscn"
	ScreenSwitcher.change_scene("res://TransitionScreen/TransitionScreen.tscn", params)

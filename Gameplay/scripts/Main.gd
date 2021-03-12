extends Node

var questions
var char_type = "ninja"

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
	
	$TextureRect.margin_top = 0
	$TextureRect.margin_bottom = OS.window_size.y*0.25
	$TextureRect.margin_right =  OS.window_size.x
	$TextureRect.margin_left = 0
	
	$Label.margin_top = 50
	$Label.margin_bottom = OS.window_size.y*0.4 - 30
	$Label.margin_right =  OS.window_size.x - 30
	$Label.margin_left = 30
	
	$LevelLabel.text = "LV. 5 - WAVE " + str(curr_q+1)
	
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func start(url):
	print('start')
	$HTTPRequest.request(url)
	
func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	# MOCK DATA
	questions = [
		{"q":"what is this? \n nothing aehwh hfeuw fowierj jiewr jiojijijiw ejie aksjdnciw rjeiwo f s ssss e werer ajidf jiwoe f vjsidfe  fjiwoef baba\n uuuu", 
		"ans":["asds","dfwef","werer","aaa"], 
		"correct":2
		},
		{"q":"bbb", 
		"ans":["awww","dfwwww","wewwwr", "one qn here"], 
		"correct":2
		},
	]
	
	q = questions[0]
	
	$Player.start($StartPosition.position, char_type)
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
	$LevelLabel.text = "LV. 5 - WAVE " + str(curr_q)
	print('timer started')
	for i in range(len(q["ans"])):
		create_enemy(i)
	
func handle_health():
	if health<= 0:
		handle_despawn()
		emit_signal('end', 'tower', false)
		queue_free()

func change_label(question):
	var str_q = question["q"] + "\n"
	for i in range(len(question["ans"])):
		str_q += ' \n '+char(65+i)+'. '+question['ans'][i]
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
	emit_signal('end', 'tower', true)
	queue_free()
	pass # Replace with function body.

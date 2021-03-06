extends CanvasLayer

# VARIABLES
var QUESTIONS_ALLOWED = 5
var student_questions_num = 0
var selected_question_box

var arr = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# note, every time this page is accessed from outside menu, query the database
	# for the 5 questions
	Api.connect("call_done", self, "user_query_done")
	Api.get_challenge_data({"player_name": Main.username})

	
	
# For the array, if they never do before, it will be [None, None....]
# If it is None, count = 0, text will display <CLICK HERE TO SELECT A QUESTION>
func user_query_done(results):
	if typeof(results)==TYPE_ARRAY && len(results) != 3:
		update_user_qns(results)
	if typeof(results)==TYPE_DICTIONARY && "dungeon" in results:
		var params = {}
		if "error" in results:
			params["text"] = "Update Fails! \nplease try again"
		else:
			params["text"] = "Dungeon Updated!"
		params["next_scene"] = "res://World_Selection/Map/ChallengeMode.tscn"
		ScreenSwitcher.change_scene("res://TransitionScreen/TransitionScreen.tscn", params)

#Store the selected question from the list

func update_user_qns(results):
	if results == []:
		arr = ['','','','','']
	else:
		for i in results:
			arr.append(i["question_body"])
		while len(arr)<5:
			arr.append("")
	
	update_Question1_text(arr[0])
	update_Question2_text(arr[1])
	update_Question3_text(arr[2])
	update_Question4_text(arr[3])
	update_Question5_text(arr[4])
	
	for question in arr:
		if question != "":
			student_questions_num += 1

#Update text of various components
func update_Question1_text(question):
	question = processQuestion(question)
	$BackgroundColor/ScrollBar/ScrollContainer/VBoxContainer/Question1/Panel/Q1button/Label.text = str(question)

func update_Question2_text(question):
	question = processQuestion(question)
	$BackgroundColor/ScrollBar/ScrollContainer/VBoxContainer/Question2/Panel/Q2button/Label.text = str(question)

func update_Question3_text(question):
	question = processQuestion(question)
	$BackgroundColor/ScrollBar/ScrollContainer/VBoxContainer/Question3/Panel/Q3button/Label.text = str(question)

func update_Question4_text(question):
	question = processQuestion(question)
	$BackgroundColor/ScrollBar/ScrollContainer/VBoxContainer/Question4/Panel/Q4button/Label.text = str(question)

func update_Question5_text(question):
	question = processQuestion(question)
	$BackgroundColor/ScrollBar/ScrollContainer/VBoxContainer/Question5/Panel/Q5button/Label.text = str(question)

#Choose question from a list of question
#param question chosen question
#return question 
func processQuestion(question):
	#CHECK THE LOGIC FOR THIS, should it be empty string? Depends on what HTTP request returns
	if question == "":
		return "<CLICK HERE TO SELECT A QUESTION>"
	else:
		return question

# For this section, go to QuestionList scene. At QuestionList Scene, when an option is selected, go back to this scene and update text
# At questionList scene if no option is selected and they go back, dont update anything
func _on_Q1button_pressed():
	selected_question_box = 1
	move_to_questions_list()
	pass


func _on_Q2button_pressed():
	selected_question_box = 2
	move_to_questions_list()
	pass

func _on_Q3button_pressed():
	selected_question_box = 3
	move_to_questions_list()
	pass

func _on_Q4button_pressed():
	selected_question_box = 4
	move_to_questions_list()
	pass

func _on_Q5button_pressed():
	selected_question_box = 5
	move_to_questions_list()
	pass

#On bBtton press, Change Scene back to the ChallengeMode
func _on_GoBackButton_pressed():
	ScreenSwitcher.change_scene("res://World_Selection/Map/ChallengeMode.tscn")
	pass

#On Button press ,check if the 5 question is chosen and update dungeon 
func _on_ProceedButton_pressed():
	# Only possible when student_questions_num == QUESTIONS_ALLOWED, the number of questions (we use 5)
	if student_questions_num == QUESTIONS_ALLOWED:
		
		# FUNCTION: HTTP Request. Update database with the current questions
		Api.update_dungeon(arr)
		
	# If condition not met, this button does nothing
		pass
	else:
		$ErrorLabel.text = "Pick 5 item before proceeding! \n"+str(student_questions_num)+'/'+str(QUESTIONS_ALLOWED)

#Show the question list scene
func move_to_questions_list():
	$BackgroundColor.hide() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.show() # Show instanced scene

# FUNCTION NEEDED: When updating database, send back the current text in the boxes. "" or None, if the text is "<CLICK HERE>"

func _on_QuestionsListPage_question_was_selected(question):
	$BackgroundColor.show() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.hide() # Hide instanced scene
	if arr[selected_question_box-1] == '':
		student_questions_num += 1
	arr[selected_question_box-1] = question
	match selected_question_box:
		1:
			update_Question1_text(question)
		2:
			update_Question2_text(question)
		3:
			update_Question3_text(question)
		4:
			update_Question4_text(question)
		5:
			update_Question5_text(question)
		_:
			pass # There shouldn't be a situation where this happens

# Show the question selection scene
func _on_QuestionsListPage_go_back_from_QuestionsList():
	$BackgroundColor.show() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.hide() # Hide instanced scene

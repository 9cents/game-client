extends CanvasLayer

var QUESTIONS_ALLOWED = 5
var student_questions_num = 0
var selected_question_box


# Called when the node enters the scene tree for the first time.
func _ready():
	# note, every time this page is accessed from outside menu, query the database
	# for the 5 questions
	# For the array, if they never do before, it will be [None, None....]
	# If it is None, count = 0, text will display <CLICK HERE TO SELECT A QUESTION>
	# FUNCTION REQUIRED: Retrieve data from HTTP request as array
	var arr = ["TEST1", "", "", "", "TEST5"]
	update_Question1_text(arr[0])
	update_Question2_text(arr[1])
	update_Question3_text(arr[2])
	update_Question4_text(arr[3])
	update_Question5_text(arr[4])
	for question in arr:
		if question != "":
			student_questions_num += 1
			
			
			
	pass

	#get_tree().change_scene("res://Map/Main Page.tscn")
	




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


func _on_GoBackButton_pressed():
	# FUNCTION FOR CHENG YUN, GO TO ANOTHER SCENE. Since this node is destroyed and recreated no need to do anything else
	get_tree().change_scene("res://World_Selection/Map/ChallengeMode.tscn")
	pass


func _on_ProceedButton_pressed():
	if student_questions_num == QUESTIONS_ALLOWED:
		# Only possible when student_questions_num == QUESTIONS_ALLOWED, the number of questions (we use 5)
		# FUNCTION FOR CHENG YUN, GO TO ANOTHER SCENE.
		get_tree().change_scene("res://World_Selection/Map/MainPage.tscn")
		# FUNCTION: HTTP Request. Update database with the current questions
	# If condition not met, this button does nothing
		pass

func move_to_questions_list():
	$BackgroundColor.hide() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.show() # Show instanced scene

# FUNCTION NEEDED: When updating database, send back the current text in the boxes. "" or None, if the text is "<CLICK HERE>"

func _on_QuestionsListPage_question_was_selected(question):
	$BackgroundColor.show() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.hide() # Hide instanced scene
	student_questions_num += 1
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


func _on_QuestionsListPage_go_back_from_QuestionsList():
	$BackgroundColor.show() # Change to question selection page scene
	$QuestionsListPage/BackgroudColor.hide() # Hide instanced scene

extends CanvasLayer

signal question_was_selected(question)
signal go_back_from_QuestionsList

# Called when the node enters the scene tree for the first time.
func _ready():
	"""
	# FUNCTION NEEDED: Receive HTTP request data in the form: categories = [category1, category2, category3]
						This is to update the category labels (each category, is a world name)
	updateCategory1_text(categories[0])
	updateCategory2_text(categories[1])
	updateCategory3_text(categories[2])
	
	# FUNCTION NEEDED: Receive HTTP request data in the form questions = [ [] [] [] ]
						List of 3 lists, containing questions
						IMPORTANT: the questions received must be what the student already has access to,
									meaning if they haven't unlocked a higher world, HTTP request dont receive that data
	"""
	Api.connect("call_done", self, "query_done")
	Api.get_world_name({})
	
	
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category1/ColorRect/MenuButton1.get_popup().connect("id_pressed", self, "_on_button1_pressed")
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category2/ColorRect/MenuButton2.get_popup().connect("id_pressed", self, "_on_button2_pressed")
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category3/ColorRect/MenuButton3.get_popup().connect("id_pressed", self, "_on_button3_pressed")

func query_done(result):
	if typeof(result)==TYPE_ARRAY && len(result)==3:
		update_world_names(result)
		Api.get_world_qns({})
		return
#	print(typeof(result))
	if typeof(result)==TYPE_DICTIONARY:
		update_qns(result["value"])
		
func update_world_names(categories):
	update_Category1_text(categories[0])
	update_Category2_text(categories[1])
	update_Category3_text(categories[2])

func update_qns(questions):
#	var questions = [["Sample 1", "2", "3", "4"], ["No"], []] #DELETE THIS AFTER HTTP QUERY SETTLED
	while len(questions) < 3:
		questions.append([])
	for question in questions[0]:
		$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category1/ColorRect/MenuButton1.get_popup().add_item(question)
	for question in questions[1]:
		$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category2/ColorRect/MenuButton2.get_popup().add_item(question)
	for question in questions[2]:
		$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category3/ColorRect/MenuButton3.get_popup().add_item(question)
	

func _on_GoBackButton_pressed():
	emit_signal("go_back_from_QuestionsList")
	#get_tree().change_scene("res://Select_Questions_Page/Select_Questions_Page.tscn")
	
func _on_button1_pressed(id):
	var item_name = $BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category1/ColorRect/MenuButton1.get_popup().get_item_text(id)
	question_selected(item_name)

func _on_button2_pressed(id):
	var item_name = $BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category2/ColorRect/MenuButton2.get_popup().get_item_text(id)
	question_selected(item_name)

func _on_button3_pressed(id):
	var item_name = $BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category3/ColorRect/MenuButton3.get_popup().get_item_text(id)
	question_selected(item_name)

func question_selected(question):
	emit_signal("question_was_selected", question)

# There will be 3 worlds, with 5 towers, and 5 levels each, with 5 questions each
func update_Category1_text(category):
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category1/ColorRect/Label.text = str(category)

func update_Category2_text(category):
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category2/ColorRect/Label.text = str(category)

func update_Category3_text(category):
	$BackgroudColor/ScrollBar/ScrollContainer/VBoxContainer/Category3/ColorRect/Label.text = str(category)

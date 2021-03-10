extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Questions_List").connect("question_was_selected", get_node("Select_Questions_Page"), "_on_Questions_List_question_was_selected")
	print("1")
	pass

func _on_Questions_List_question_was_selected(question):
	print("here")
	$Select_Questions_Page._on_QuestionsListPage_question_was_selected(question)

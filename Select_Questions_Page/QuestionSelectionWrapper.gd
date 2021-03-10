extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Select_Questions_Page").connect("question_was_selected", get_node("QuestionsListPage"), "_on_Select_Questions_Page_question_was_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

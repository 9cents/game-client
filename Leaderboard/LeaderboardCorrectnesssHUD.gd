extends CanvasLayer

signal leaderboard

# Called when the node enters the scene tree for the first time.
func _ready():
	#FUNCTION: DO 2 HTTP REQUESTS TO GET NECESSARY INFO, EVERY TIME THIS PAGE IS ACCESSED
	# 1 request is for top 10 info
	# 1 request is for user's info
	"""
	var top_10_list = HTTP Request
	var student_info = HTTP Request
	update_leaderboard(top_10_list)
	update_student_info(student_info)
	"""
	Api.connect("call_done", self, "get_leaderboard_all_done")
	Api.get_leaderboard2_all({})
	Api.get_leaderboard2_user({})
	$ColorRect/TextureButton.connect("pressed", self , "Close")
	pass # Replace with function body.
	
#On button press, change scene
func Close():
	ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")


#Function to update scores. Receive databse information
#Required:
#	Top 10 students' names in terms of higher percentage, in sorted order of rank
#	and the higher percentage correct
#Get the leaderboard ranking of every users
#param result store the leaderboard ranking
func get_leaderboard_all_done(result):
	if result["type"] == 'all':
		update_leaderboard(result["value"])
	else:
		update_student_info(result["value"])
	
#Show the top 10 ranking on the Leaderboard 
#param top_10_list array to store the top 10 ranking user
func update_leaderboard(top_10_list):
	#For now assume top_10_list format is:
		#[ [student_name, Correct percentage], [student_name, Correct percentage] ...]
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control1/Label.text = str(top_10_list[0][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control1/CorrectPercent.text = str(top_10_list[0][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control2/Label.text = str(top_10_list[1][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control2/CorrectPercent.text = str(top_10_list[1][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control3/Label.text = str(top_10_list[2][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control3/CorrectPercent.text = str(top_10_list[2][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control4/Label.text = str(top_10_list[3][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control4/CorrectPercent.text = str(top_10_list[3][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control5/Label.text = str(top_10_list[4][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control5/CorrectPercent.text = str(top_10_list[4][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control6/Label.text = str(top_10_list[5][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control6/CorrectPercent.text = str(top_10_list[5][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control7/Label.text = str(top_10_list[6][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control7/CorrectPercent.text = str(top_10_list[6][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control8/Label.text = str(top_10_list[7][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control8/CorrectPercent.text = str(top_10_list[7][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control9/Label.text = str(top_10_list[8][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control9/CorrectPercent.text = str(top_10_list[8][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control10/Label.text = str(top_10_list[9][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control10/CorrectPercent.text = str(top_10_list[9][1])


#Function to update scores. Receive databse information
#The current student's correct answer percentage, and overall rank
func update_student_info(student_data):
#and assume current_student format is:
		#[rank, Correct percentage]
	$ColorRect/YourRankValue.text = str(student_data[0])
	$ColorRect/YourCorrectPercentValue.text = str(student_data[1])


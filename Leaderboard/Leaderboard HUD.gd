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
	Api.get_leaderboard_all({})
	Api.get_leaderboard_user({})
	$ColorRect/TextureButton.connect("pressed", self , "Close")
	pass # Replace with function body.
	
func Close():
	ScreenSwitcher.change_scene("res://World_Selection/Map/MainPage.tscn")
#TODO
#Function for on button press going to leaderboard (Not this scene)

#Function to update scores. Receive databse information
#Required:
#	Top 10 students' names in terms of levels cleared, in sorted order of rank
#	and the number of levels cleared

func get_leaderboard_all_done(result):
	if result["type"] == 'all':
		update_leaderboard(result["value"])
	else:
		update_student_info(result["value"])
	
	
func update_leaderboard(top_10_list):
	#For now assume top_10_list format is:
		#[ [student_name, score], [student_name, score] ...]
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control1/Label.text = str(top_10_list[0][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control1/LevelsCleared.text = str(top_10_list[0][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control2/Label.text = str(top_10_list[1][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control2/LevelsCleared.text = str(top_10_list[1][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control3/Label.text = str(top_10_list[2][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control3/LevelsCleared.text = str(top_10_list[2][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control4/Label.text = str(top_10_list[3][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control4/LevelsCleared.text = str(top_10_list[3][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control5/Label.text = str(top_10_list[4][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control5/LevelsCleared.text = str(top_10_list[4][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control6/Label.text = str(top_10_list[5][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control6/LevelsCleared.text = str(top_10_list[5][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control7/Label.text = str(top_10_list[6][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control7/LevelsCleared.text = str(top_10_list[6][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control8/Label.text = str(top_10_list[7][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control8/LevelsCleared.text = str(top_10_list[7][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control9/Label.text = str(top_10_list[8][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control9/LevelsCleared.text = str(top_10_list[8][1])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control10/Label.text = str(top_10_list[9][0])
	$ColorRect/ScrollBar/ScrollContainer/VBoxContainer/Control10/LevelsCleared.text = str(top_10_list[9][1])


#Function to update scores. Receive databse information
#Required:
#The current student's number of levels cleared, and overall rank
func update_student_info(student_data):
#and assume current_student format is:
		#[rank, score]
	$ColorRect/YourRankValue.text = str(student_data[0])
	$ColorRect/YourLevelsClearedValue.text = str(student_data[1])


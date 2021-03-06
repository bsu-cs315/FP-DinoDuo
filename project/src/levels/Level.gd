extends Node2D

var locked := false
var key1 := false
var key2 := false

func _ready():
	if Global.levelNumber <= 3:
		Global.nextLevel = "res://src/levels/Level" + String(Global.levelNumber+1) + ".tscn"
		Global.levelNumber += 1
		
	for child in get_children():
		if child.name == "Key":
			locked = true
		
	$LevelTime.start()


func _process(_delta):
	get_node("Camera/HUD/LevelTimeLabel").text = str(int($LevelTime.time_left)) + " Seconds Remaining"
	check_goal()
	
	
func check_goal():
	if ($Player.at_goal or $Player2.at_goal) and (!$Player.at_goal or !$Player2.at_goal):
		$Camera/HUD/HintLabel.show()
	elif $Player.at_goal == true and $Player2.at_goal == true:
		$Camera/HUD/HintLabel.hide()
		if locked == true and (!key1 or !key2):
			$Camera/HUD/HintKey.show()
		else:
			$Camera/HUD/HintKey.hide()
			win_level()
	else:
		$Camera/HUD/HintLabel.hide()
		$Camera/HUD/HintKey.hide()
		
		
		
func _on_LevelTime_timeout():
	lose_level()
	get_tree().paused = true


func win_level():
	get_node("Camera/HUD/GameResult").show()
	if Global.levelNumber == 4:
		get_node("Camera/HUD/GameResult/GameOverText").show()
	else:
		get_node("Camera/HUD/GameResult/WinText").show()
	get_tree().paused = true


func lose_level():
	get_node("Camera/HUD/GameResult").show()
	get_node("Camera/HUD/GameResult/LoseText").show()
	get_tree().paused = true

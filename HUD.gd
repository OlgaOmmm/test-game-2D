extends CanvasLayer

signal start_game
signal button_up
signal button_down
signal button_left
signal button_right

func update_score(value):
	$MarginContainer/ScoreLabel.text = str(value)

func update_timer(value):
	if len(str(value)) == 1:
		$MarginContainer/TimeLabel.text = "0: 0" + str(value)
	else:
		$MarginContainer/TimeLabel.text = "0: " + str(value)

func update_level(value):
	$MarginContainer/LevelLabel.text = str(value)

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	$MessageLabel.hide()
	emit_signal("start_game")
	$MarginContainer/ScoreLabel.show()
	$MarginContainer/LevelLabel.show()
	$MarginContainer/TimeLabel.show()
	$ButtonDown.show()
	$ButtonLeft.show()
	$ButtonRight.show()
	$ButtonUp.show()
	$MarginContainer2/Label.show()
	$MarginContainer2/Label2.show()
	$MarginContainer2/Label3.show()
	$LabelRooles.hide()

func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "NEW GAME!"
	$MessageLabel.show()

func _on_ButtonUp_pressed():
	emit_signal("button_up")

func _on_ButtonDown_pressed():
	emit_signal("button_down")

func _on_ButtonRight_pressed():
	emit_signal("button_right")

func _on_ButtonLeft_pressed():
	emit_signal("button_left")

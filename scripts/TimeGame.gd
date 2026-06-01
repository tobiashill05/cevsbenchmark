extends Control  # Your root is TimeGame, so script goes here

# Node references (match exact names)
@onready var button = $"Button"
@onready var label = $ColorRect/TextLabel
@onready var timer = $Timer
@onready var cevwait = $CevWait
@onready var cevblink = $CevBlink

@onready var niceOne = $vl_NiceOne
@onready var welcomeTG = $vl_WelcomeTG
# Game variables
var start_time = 0.0
var game_running = false
var target_time = 10.0  # target time in seconds
var countdown = 10

func _ready():
	label.text = "Welcome to the time test! To begin, press anywhere. Then, press again when you think 10 seconds have passed!"
	welcomeTG.play()
	button.pressed.connect(on_button_pressed)
	cevwait.visible = false
	cevblink.visible = true
	$CevWait/AnimationPlayer.play("cevWait")
	$CevBlink/AnimationPlayer.play("cevBlink")

func on_button_pressed():
	if not game_running:
		start_game()
	else:
		end_game()

func start_game():
	$CountdownTimer.stop()
	countdown=10
	cevwait.visible = true
	cevblink.visible = false
	timer.stop()
	game_running = true
	start_time = Time.get_ticks_msec() / 1000.0  # Godot 4
	label.text = "Press when you think 10 seconds have passed!"

func end_game():
	$CountdownTimer.start()
	cevwait.visible = false
	cevblink.visible = true
	game_running = false
	var current_time = Time.get_ticks_msec() / 1000.0  # Godot 4
	var elapsed = current_time - start_time
	var difference = abs(elapsed - target_time)
	timer.start()
	label.text = "You were %.2f seconds off! \nPress to try again, or wait to return to the menu." % difference
	niceOne.play()

func _on_auto_return_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/MenuScreen.tscn")
	



func _on_countdown_timer_timeout():
	countdown -= 1
	print(countdown)
	if countdown > 0:
		label.text = label.text.split("\n")[0] + "\nPress to try again, or wait to return to the menu. \nReturning to menu in " + str(countdown)
	else:
		$CountdownTimer.stop()

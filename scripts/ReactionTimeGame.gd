extends Control

@onready var button = $Button
@onready var label = $ColorRect/TextLabel
@onready var cev= $Cev
@onready var introcev= $IntroCev

#voicelines
@onready var niceRT = $vl_NiceRT
@onready var now = $vl_NOW
@onready var welcomeRTG = $vl_WelcomeRTG
var state = "idle"
var start_time = 0
var countdown = 10

func _ready():
	randomize()
	set_idle()
	cev.visible=false
	welcomeRTG.play()

func set_idle():
	state = "idle"
	label.text = "Welcome to the Reaction Time Test! Press anywhere to begin, then be prepared to press again when I say so!"
	button.modulate = Color.WHITE
	cev.visible=false
	introcev.visible=true


func _on_button_pressed():
	
	countdown=10
	if state == "idle":
		start_waiting()
		
	elif state == "waiting":
		# Clicked too early
		label.text = "Too Soon!\nPress to try again"
		button.modulate = Color.DARK_RED
		state = "result"
		
	elif state == "ready":
		var reaction = Time.get_ticks_msec() - start_time
		label.text = str(reaction) + "ms is your reaction time!"
		niceRT.play()
		button.modulate = Color.BLUE
		state = "result"
		$AutoReturnTimer.start()
		$CountdownTimer.start()
		
		
	elif state == "result":
	
		$AutoReturnTimer.stop()
		$CountdownTimer.stop()
		set_idle()

func start_waiting():
	introcev.visible=false
	state = "waiting"
	label.text = "Wait..."
	button.modulate = Color.RED
	
	var delay = randf_range(3.0, 7.0)
	await get_tree().create_timer(delay).timeout
	
	if state == "waiting":  # Prevents race condition
		state = "ready"
		label.text = "NOW!"
		now.play()
		cev.visible=true
		button.modulate = Color.GREEN
		start_time = Time.get_ticks_msec()





func _on_auto_return_timer_timeout():
	get_tree().change_scene_to_file("res://Scenes/MenuScreen.tscn")
	


func _on_countdown_timer_timeout():
	countdown -= 1
	print(countdown)
	if countdown > 0:
		label.text = label.text.split("\n")[0] + "\nPress to try again, or wait to return to the menu. \nReturning to menu in " + str(countdown)
	else:
		$CountdownTimer.stop()
		

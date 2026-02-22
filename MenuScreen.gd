extends Control

# Updated paths
@onready var reaction_button = $CenterContainer/VBoxContainer/ReactionButton
@onready var simon_button = $CenterContainer/VBoxContainer/SimonButton
@onready var time_button = $CenterContainer/VBoxContainer/TimeButton


func _ready():
	# Connect button signals
	reaction_button.pressed.connect(_on_reaction_pressed)
	simon_button.pressed.connect(_on_simon_pressed)
	time_button.pressed.connect(_on_time_pressed)
	print(DisplayServer.screen_get_size())
	Music.play_music(preload("res://Sounds/otherside (mp3cut.net).mp3"))
	$vl_ImKev.play()
	
# Change scenes (paths include your Scenes folder)
func _on_reaction_pressed():
	get_tree().change_scene_to_file("res://Scenes/ReactionTimeGame.tscn")
func _on_simon_pressed():
	get_tree().change_scene_to_file("res://Scenes/MemoryFlashGame.tscn")
func _on_time_pressed():
	get_tree().change_scene_to_file("res://Scenes/TimeGame.tscn")
func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")

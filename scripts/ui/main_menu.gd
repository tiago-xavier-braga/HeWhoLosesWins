class_name MainMenu
extends Control

const START_SCENE_PATH: String = "res://scenes/ui/start_menu.tscn"

@export var game_scene: PackedScene
@export var puzzle_menu_scene: PackedScene
@export var options: Control
@export var difficulties: Array[CpuDifficulty]


# Connected here because a connection with a bound resource is lost in the web export.
func _ready() -> void:
	var index: int = 0
	for child: Node in options.get_children():
		if child is Button:
			(child as Button).pressed.connect(_on_difficulty_pressed.bind(difficulties[index]))
			index += 1


func _on_difficulty_pressed(difficulty: CpuDifficulty) -> void:
	GameSettings.difficulty = difficulty
	get_tree().change_scene_to_packed(game_scene)


func _on_puzzles_pressed() -> void:
	get_tree().change_scene_to_packed(puzzle_menu_scene)


# By path, because the start menu scene already references this scene.
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(START_SCENE_PATH)

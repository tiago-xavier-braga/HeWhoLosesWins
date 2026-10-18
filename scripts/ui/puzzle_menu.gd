class_name PuzzleMenu
extends Control

const BACK_SCENE_PATH: String = "res://scenes/ui/main_menu.tscn"

@export var puzzle_scene: PackedScene
@export var grid: GridContainer
@export var open_template: Button
@export var locked_template: Button
@export var puzzles: Array[PuzzleLevel]


# Built from the list, so adding a level only means adding it to `puzzles`. Connected here
# because a connection with a bound resource is lost in the web export.
func _ready() -> void:
	for index: int in puzzles.size():
		var unlocked: bool = index == 0 or puzzles[index - 1] in GameSettings.solved_puzzles
		var button: Button = (open_template if unlocked else locked_template).duplicate()
		if unlocked:
			button.text = str(index + 1)
			button.pressed.connect(_on_puzzle_pressed.bind(puzzles[index]))
		button.show()
		grid.add_child(button)


func _on_puzzle_pressed(level: PuzzleLevel) -> void:
	GameSettings.puzzle = level
	get_tree().change_scene_to_packed(puzzle_scene)


# By path, because the main menu scene already references this scene.
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(BACK_SCENE_PATH)

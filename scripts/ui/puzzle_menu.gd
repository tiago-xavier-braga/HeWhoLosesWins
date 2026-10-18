class_name PuzzleMenu
extends Control

const BACK_SCENE_PATH: String = "res://scenes/ui/main_menu.tscn"
# Inside section_template, which is duplicated once per section.
const TITLE_PATH: NodePath = ^"Header/Title"
const IDEA_PATH: NodePath = ^"Header/Idea"
const LEVELS_PATH: NodePath = ^"Levels"

@export var puzzle_scene: PackedScene
@export var scroll: ScrollContainer
@export var section_list: Container
@export var section_template: Control
@export var open_template: Button
@export var next_template: Button
@export var locked_template: Button
@export var sections: Array[PuzzleSection]

# Every level in menu order, so unlocking and the puzzle's Next button ignore the sections.
var _levels: Array[PuzzleLevel] = []


# Built from the sections, so adding a level only means adding it to a section. Connected here
# because a connection with a bound resource is lost in the web export.
func _ready() -> void:
	var current_section: Control = null
	for section: PuzzleSection in sections:
		var view: Control = section_template.duplicate()
		(view.get_node(TITLE_PATH) as Label).text = section.title
		(view.get_node(IDEA_PATH) as Label).text = section.idea
		for level: PuzzleLevel in section.levels:
			# Puzzles unlock in order, so the one unlocked but not solved yet is the current one.
			var unlocked: bool = _levels.is_empty() or _levels.back() in GameSettings.solved_puzzles
			var solved: bool = level in GameSettings.solved_puzzles
			if unlocked and not solved:
				current_section = view
			_levels.append(level)
			_add_button(view.get_node(LEVELS_PATH), level, unlocked, solved)
		view.show()
		section_list.add_child(view)

	if current_section != null:
		# The new sections only get their positions when the containers sort, at the end of the
		# frame.
		await get_tree().process_frame
		scroll.scroll_vertical = int(current_section.position.y)


func _add_button(row: Container, level: PuzzleLevel, unlocked: bool, solved: bool) -> void:
	var template: Button = locked_template
	if unlocked:
		template = open_template if solved else next_template
	var button: Button = template.duplicate()
	if unlocked:
		button.text = str(_levels.size())
		button.pressed.connect(_on_puzzle_pressed.bind(level))
	button.show()
	row.add_child(button)


func _on_puzzle_pressed(level: PuzzleLevel) -> void:
	GameSettings.puzzles = _levels
	GameSettings.puzzle = level
	get_tree().change_scene_to_packed(puzzle_scene)


# By path, because the main menu scene already references this scene.
func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(BACK_SCENE_PATH)

class_name PuzzleSection
extends Resource

## A group of puzzles shown together in the puzzle menu, all built around one idea.

@export var title: String = ""
## One line that tells the player the idea the section teaches.
@export var idea: String = ""
@export var levels: Array[PuzzleLevel] = []

extends Node

const SOLVED_PUZZLES_KEY: String = "solved_puzzles"

var difficulty: CpuDifficulty = preload("res://resources/cpu_hard.tres")
# Only read by lvl_puzzle; a normal match ignores it.
var puzzle: PuzzleLevel = null
# The puzzle menu's order, so a solved puzzle knows which one comes next.
var puzzles: Array[PuzzleLevel] = []


func is_solved(level: PuzzleLevel) -> bool:
	return _puzzle_id(level) in SaveKit.get_value(SOLVED_PUZZLES_KEY)


func mark_solved(level: PuzzleLevel) -> void:
	if is_solved(level):
		return
	var solved: Array = SaveKit.get_value(SOLVED_PUZZLES_KEY)
	solved.append(_puzzle_id(level))
	SaveKit.set_value(SOLVED_PUZZLES_KEY, solved)
	SaveKit.save()


# The file name, because the save is JSON and can't hold the resource itself.
func _puzzle_id(level: PuzzleLevel) -> String:
	return level.resource_path.get_file().get_basename()

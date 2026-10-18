extends Node

var difficulty: CpuDifficulty = preload("res://resources/cpu_hard.tres")
# Only read by lvl_puzzle; a normal match ignores it.
var puzzle: PuzzleLevel = null
# Kept for the session only; saving is a later task.
var solved_puzzles: Array[PuzzleLevel] = []

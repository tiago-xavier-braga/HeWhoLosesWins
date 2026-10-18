extends Node

var difficulty: CpuDifficulty = preload("res://resources/cpu_hard.tres")
# Only read by lvl_puzzle; a normal match ignores it.
var puzzle: PuzzleLevel = null
# The puzzle menu's order, so a solved puzzle knows which one comes next.
var puzzles: Array[PuzzleLevel] = []
# Kept for the session only; saving is a later task.
var solved_puzzles: Array[PuzzleLevel] = []

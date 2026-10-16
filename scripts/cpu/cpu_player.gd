class_name CpuPlayer
extends Node

const SETTLE_FRAMES: int = 2

@export var difficulty: CpuDifficulty

var player: PlayerData

var _search: CpuSearch


func initialize(cpu: PlayerData, players: Array[PlayerData], board_size: int) -> void:
	player = cpu
	_search = CpuSearch.new(MoveRules.new(players, board_size), players, board_size, cpu)


func on_turn_changed(current: PlayerData) -> void:
	if current != player:
		return
	await get_tree().create_timer(difficulty.think_delay).timeout
	var move: MoveRules.Move = _search.choose(difficulty.search_depth)
	# The search blocks the frame, so the next delta is huge and would make the tween snap.
	for _frame: int in SETTLE_FRAMES:
		await get_tree().process_frame
	player.request_move(move.piece, move.path.back())

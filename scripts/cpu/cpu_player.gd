class_name CpuPlayer
extends Node

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
	player.request_move(move.piece, move.path.back())

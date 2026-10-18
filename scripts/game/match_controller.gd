class_name MatchController
extends Node

signal turn_changed(player: PlayerData)

const START_ROWS: int = 3
const WINS_TEXT: String = "WINS!"

@export var board_spawner: BoardSpawner
@export var pieces_spawner: PiecesSpawner
@export var pointer_input: PointerInput
@export var piece_mover: PieceMover
@export var move_hints: MoveHints
@export var win_panel: WinPanel
@export var cpu_player: CpuPlayer

var players: Array[PlayerData] = []
var current_player: PlayerData

var _current_index: int = 0


func _ready() -> void:
	start_match()


func start_match() -> void:
	board_spawner.initialize()
	players = [PlayerData.new(true), PlayerData.new(false)]
	_set_up_match()
	pointer_input.initialize(players[0], board_spawner)
	piece_mover.initialize(players, board_spawner)
	move_hints.initialize(pointer_input, piece_mover, board_spawner)
	cpu_player.initialize(players[1], players, board_spawner.board_size)
	turn_changed.connect(cpu_player.on_turn_changed)
	piece_mover.piece_moved.connect(_on_piece_moved)
	_set_turn(0)


# PuzzleController overrides this to start from a level instead.
func _set_up_match() -> void:
	cpu_player.difficulty = GameSettings.difficulty
	for player: PlayerData in players:
		_spawn_player_pieces(player)


func _spawn_player_pieces(player: PlayerData) -> void:
	var size: int = board_spawner.board_size
	var first_row: int = size - START_ROWS if player.is_white else 0
	var cells: Array[Vector2i] = []
	for y: int in range(first_row, first_row + START_ROWS):
		for x: int in size:
			if (x + y) % 2 != 0:
				cells.append(Vector2i(x, y))
	pieces_spawner.spawn_pieces(player, cells, board_spawner.square_size, board_spawner.board)


func _set_turn(index: int) -> void:
	_current_index = index
	current_player = players[index]
	pointer_input.player = current_player
	pointer_input.set_process_unhandled_input(current_player != cpu_player.player)
	piece_mover.current_player = current_player
	turn_changed.emit(current_player)


func _on_piece_moved(_piece: Piece) -> void:
	for player: PlayerData in players:
		if player.has_won():
			_finish_match(player)
			return
	var next_index: int = (_current_index + 1) % players.size()
	if not piece_mover.can_move(players[next_index]):
		_finish_match(players[next_index])
		return
	_set_turn(next_index)


func _finish_match(winner: PlayerData) -> void:
	pointer_input.set_process_unhandled_input(false)
	_show_result(winner)


# PuzzleController overrides this to show solved or failed instead of the winner.
func _show_result(winner: PlayerData) -> void:
	win_panel.show_result("Player %d" % (players.find(winner) + 1), WINS_TEXT)

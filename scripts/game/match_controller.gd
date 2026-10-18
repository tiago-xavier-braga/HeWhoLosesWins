class_name MatchController
extends Node

signal turn_changed(player: PlayerData)

const START_ROWS: int = 3
const WINS_TEXT: String = "WINS!"
const MODE_TEXT: String = "VS CPU"

@export var board_spawner: BoardSpawner
@export var pieces_spawner: PiecesSpawner
@export var pointer_input: PointerInput
@export var piece_mover: PieceMover
@export var move_hints: MoveHints
@export var win_panel: WinPanel
@export var cpu_player: CpuPlayer
@export var hud: GameHud
## Seconds the board stays visible after the last move, before the result panel.
@export var result_delay: float = 0.5

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
	hud.initialize(players[0], players[1], piece_mover, _mode_text(),
			cpu_player.difficulty.display_name)
	turn_changed.connect(cpu_player.on_turn_changed)
	turn_changed.connect(hud.on_turn_changed)
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


# PuzzleController overrides this to show the puzzle number and its move limit.
func _mode_text() -> String:
	return MODE_TEXT


func _set_turn(index: int) -> void:
	_current_index = index
	current_player = players[index]
	pointer_input.player = current_player
	pointer_input.set_process_unhandled_input(current_player != cpu_player.player)
	piece_mover.current_player = current_player
	turn_changed.emit(current_player)


func _on_piece_moved(_piece: Piece, _from_cell: Vector2i) -> void:
	for player: PlayerData in players:
		if player.has_won():
			_finish_match(player)
			return
	var next_index: int = (_current_index + 1) % players.size()
	if not piece_mover.can_move(players[next_index]):
		_finish_match(players[next_index])
		return
	_set_turn(next_index)


# The match ends as soon as the last move changes the state, so the panel waits for its
# animation; otherwise the player never sees the move that decided the game.
func _finish_match(winner: PlayerData) -> void:
	pointer_input.set_process_unhandled_input(false)
	await piece_mover.move_animated
	await get_tree().create_timer(result_delay).timeout
	_show_result(winner)


# PuzzleController overrides this to show solved or failed instead of the winner.
func _show_result(winner: PlayerData) -> void:
	var title: String = "Player %d" % (players.find(winner) + 1)
	win_panel.show_result(title, WINS_TEXT, winner != cpu_player.player)

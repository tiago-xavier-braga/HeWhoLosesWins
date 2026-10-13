class_name MatchController
extends Node

signal turn_changed(player: PlayerData)

const START_ROWS: int = 3

@export var board_spawner: BoardSpawner
@export var pieces_spawner: PiecesSpawner
@export var pointer_input: PointerInput
@export var piece_mover: PieceMover

var players: Array[PlayerData] = []
var current_player: PlayerData

var _current_index: int = 0


func _ready() -> void:
	start_match()


func start_match() -> void:
	board_spawner.initialize()
	players = [PlayerData.new(true), PlayerData.new(false)]
	for player: PlayerData in players:
		_spawn_player_pieces(player)
	pointer_input.initialize(players[0], board_spawner)
	piece_mover.initialize(players, board_spawner)
	piece_mover.piece_moved.connect(_on_piece_moved)
	_set_turn(0)


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
	turn_changed.emit(current_player)


func _on_piece_moved(_piece: Piece) -> void:
	_set_turn((_current_index + 1) % players.size())

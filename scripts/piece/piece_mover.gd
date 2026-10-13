class_name PieceMover
extends Node

signal piece_moved(piece: Piece)

const MOVE_DURATION: float = 0.2
const CAPTURE_FADE_DURATION: float = 0.15

var _players: Array[PlayerData] = []
var _rules: MoveRules
var _square_size: Vector2
var _board_size: int


func initialize(players: Array[PlayerData], board_spawner: BoardSpawner) -> void:
	_players = players
	_square_size = board_spawner.square_size
	_board_size = board_spawner.board_size
	_rules = MoveRules.new(players, _board_size)
	for player: PlayerData in players:
		player.move_requested.connect(_on_move_requested)


# The state changes at once, so the turn can pass; the animation only catches up.
func _on_move_requested(piece: Piece, to_cell: Vector2i) -> void:
	var move: MoveRules.Move = _rules.find_move(_owner_of(piece), piece, to_cell)
	if move == null:
		return

	for taken: Piece in move.captured:
		_owner_of(taken).remove_piece(taken)
	piece.cell = move.path.back()
	if _reaches_last_row(piece):
		piece.set_checker()
	piece_moved.emit(piece)
	_animate_step(move, 0)


func _animate_step(move: MoveRules.Move, index: int) -> void:
	if index >= move.path.size():
		return
	if index < move.captured.size():
		var taken: Piece = move.captured[index]
		LeafTween.fade(taken, 0.0, CAPTURE_FADE_DURATION).set_on_complete(taken.queue_free)

	var target: Vector2 = (Vector2(move.path[index]) + Vector2(0.5, 0.5)) * _square_size
	LeafTween.move(move.piece, target, MOVE_DURATION) \
		.set_ease(LeafTweenEasing.EaseType.OUT_QUAD) \
		.set_on_complete(_animate_step.bind(move, index + 1))


func _owner_of(piece: Piece) -> PlayerData:
	for player: PlayerData in _players:
		if piece in player.pieces:
			return player
	return null


func _reaches_last_row(piece: Piece) -> bool:
	if piece.is_checker:
		return false
	return piece.cell.y == (0 if piece.is_white else _board_size - 1)

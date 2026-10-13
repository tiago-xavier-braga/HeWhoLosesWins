class_name MoveRules
extends RefCounted

const DIRECTIONS: Array[Vector2i] = [
	Vector2i(1, 1), Vector2i(1, -1), Vector2i(-1, 1), Vector2i(-1, -1),
]

var _players: Array[PlayerData]
var _board_size: int


class Move:
	var piece: Piece
	var path: Array[Vector2i]
	var captured: Array[Piece]

	func _init(moving_piece: Piece, landing_cells: Array[Vector2i], taken: Array[Piece]) -> void:
		piece = moving_piece
		path = landing_cells
		captured = taken


func _init(players: Array[PlayerData], board_size: int) -> void:
	_players = players
	_board_size = board_size


# A multi-capture is a single forced move. Clicking any square along its path is enough:
# the one that ends there wins, otherwise the first path that passes through it.
func find_move(player: PlayerData, piece: Piece, to_cell: Vector2i) -> Move:
	var passing: Move = null
	for move: Move in get_legal_moves(player):
		if move.piece != piece:
			continue
		if move.path.back() == to_cell:
			return move
		if passing == null and to_cell in move.path:
			passing = move
	return passing


func get_legal_moves(player: PlayerData) -> Array[Move]:
	var captures: Array[Move] = []
	for piece: Piece in player.pieces:
		var path: Array[Vector2i] = []
		var taken: Array[Piece] = []
		_collect_captures(piece, piece.cell, taken, path, captures)

	var moves: Array[Move] = []
	if captures.is_empty():
		for piece: Piece in player.pieces:
			_collect_steps(piece, moves)
		return moves

	var most: int = 0
	for move: Move in captures:
		most = maxi(most, move.captured.size())
	for move: Move in captures:
		if move.captured.size() == most:
			moves.append(move)
	return moves


func _collect_captures(piece: Piece, from: Vector2i, taken: Array[Piece],
		path: Array[Vector2i], results: Array[Move]) -> void:
	var extended: bool = false
	for direction: Vector2i in DIRECTIONS:
		var victim_cell: Vector2i = from + direction
		if piece.is_checker:
			while _in_bounds(victim_cell) and _piece_at(victim_cell, piece) == null:
				victim_cell += direction

		var victim: Piece = _piece_at(victim_cell, piece)
		if victim == null or victim.is_white == piece.is_white or victim in taken:
			continue

		var landing: Vector2i = victim_cell + direction
		while _in_bounds(landing) and _piece_at(landing, piece) == null:
			extended = true
			taken.append(victim)
			path.append(landing)
			_collect_captures(piece, landing, taken, path, results)
			taken.pop_back()
			path.pop_back()
			if not piece.is_checker:
				break
			landing += direction

	if not extended and not taken.is_empty():
		results.append(Move.new(piece, path.duplicate(), taken.duplicate()))


func _collect_steps(piece: Piece, moves: Array[Move]) -> void:
	var forward: int = -1 if piece.is_white else 1
	for direction: Vector2i in DIRECTIONS:
		if not piece.is_checker and direction.y != forward:
			continue
		var cell: Vector2i = piece.cell + direction
		while _in_bounds(cell) and _piece_at(cell, piece) == null:
			var path: Array[Vector2i] = [cell]
			var taken: Array[Piece] = []
			moves.append(Move.new(piece, path, taken))
			if not piece.is_checker:
				break
			cell += direction


func _in_bounds(cell: Vector2i) -> bool:
	return cell.x >= 0 and cell.y >= 0 and cell.x < _board_size and cell.y < _board_size


func _piece_at(cell: Vector2i, ignore: Piece) -> Piece:
	for player: PlayerData in _players:
		for piece: Piece in player.pieces:
			if piece != ignore and piece.cell == cell:
				return piece
	return null

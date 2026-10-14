class_name CpuSearch
extends RefCounted

const WIN_SCORE: float = 1000.0
const CHECKER_WEIGHT: float = 1.5

var _rules: MoveRules
var _players: Array[PlayerData]
var _board_size: int
var _me: PlayerData


class Undo:
	var piece: Piece
	var cell: Vector2i
	var was_checker: bool
	var victims: Array[Piece]


func _init(rules: MoveRules, players: Array[PlayerData], board_size: int, me: PlayerData) -> void:
	_rules = rules
	_players = players
	_board_size = board_size
	_me = me


# The CPU wins by losing pieces, so it looks for the move that leaves it with the least
# material compared to the opponent. Depth 0 or less picks a random move.
func choose(depth: int) -> MoveRules.Move:
	var moves: Array[MoveRules.Move] = _rules.get_legal_moves(_me)
	if depth <= 0:
		return moves.pick_random()

	var best: MoveRules.Move = moves[0]
	var best_score: float = -INF
	for move: MoveRules.Move in moves:
		var undo: Undo = _apply(move)
		var score: float = _minimax(depth - 1, _other(_me), -INF, INF)
		_revert(undo)
		if score > best_score:
			best_score = score
			best = move
	return best


func _minimax(depth: int, mover: PlayerData, alpha: float, beta: float) -> float:
	if _me.pieces.is_empty():
		return WIN_SCORE + depth
	if _other(_me).pieces.is_empty():
		return -WIN_SCORE - depth
	var moves: Array[MoveRules.Move] = _rules.get_legal_moves(mover)
	if moves.is_empty():
		return WIN_SCORE + depth if mover == _me else -WIN_SCORE - depth
	if depth == 0:
		return _evaluate()

	var maximizing: bool = mover == _me
	var best: float = -INF if maximizing else INF
	for move: MoveRules.Move in moves:
		var undo: Undo = _apply(move)
		var score: float = _minimax(depth - 1, _other(mover), alpha, beta)
		_revert(undo)
		if maximizing:
			best = maxf(best, score)
			alpha = maxf(alpha, best)
		else:
			best = minf(best, score)
			beta = minf(beta, best)
		if beta <= alpha:
			break
	return best


func _evaluate() -> float:
	return _material(_other(_me)) - _material(_me)


func _material(player: PlayerData) -> float:
	var total: float = 0.0
	for piece: Piece in player.pieces:
		total += CHECKER_WEIGHT if piece.is_checker else 1.0
	return total


# Mirrors PieceMover on the live pieces without touching nodes or emitting signals.
func _apply(move: MoveRules.Move) -> Undo:
	var undo: Undo = Undo.new()
	undo.piece = move.piece
	undo.cell = move.piece.cell
	undo.was_checker = move.piece.is_checker
	undo.victims = move.captured
	var victims_owner: PlayerData = _other(_owner_of(move.piece))
	for victim: Piece in move.captured:
		victims_owner.pieces.erase(victim)
	move.piece.cell = move.path.back()
	var last_row: int = 0 if move.piece.is_white else _board_size - 1
	if move.piece.cell.y == last_row:
		move.piece.is_checker = true
	return undo


func _revert(undo: Undo) -> void:
	undo.piece.cell = undo.cell
	undo.piece.is_checker = undo.was_checker
	var victims_owner: PlayerData = _other(_owner_of(undo.piece))
	victims_owner.pieces.append_array(undo.victims)


func _owner_of(piece: Piece) -> PlayerData:
	return _players[0] if piece.is_white == _players[0].is_white else _players[1]


func _other(player: PlayerData) -> PlayerData:
	return _players[1] if player == _players[0] else _players[0]

class_name MoveHints
extends Node

var _piece_mover: PieceMover
var _squares: Dictionary[Vector2i, Square]
var _lit: Array[Square] = []
var _last_move: Array[Square] = []


func initialize(pointer_input: PointerInput, piece_mover: PieceMover,
		board_spawner: BoardSpawner) -> void:
	_piece_mover = piece_mover
	_squares = board_spawner.squares
	pointer_input.piece_selected.connect(_on_piece_selected)
	pointer_input.selection_cleared.connect(_clear)
	piece_mover.piece_moved.connect(_on_piece_moved)


func _on_piece_selected(piece: Piece) -> void:
	_clear()
	_light(piece.cell, "selected")
	for move: MoveRules.Move in _piece_mover.get_moves(piece):
		var effect: String = "capture_hint" if not move.captured.is_empty() else "move_hint"
		for cell: Vector2i in move.path:
			_light(cell, effect)


# Only the start and end squares, even for a multi-capture, so the CPU's move is easy to follow.
func _on_piece_moved(piece: Piece, from_cell: Vector2i) -> void:
	for square: Square in _last_move:
		square.set_last_move(false)
	_last_move.clear()
	_last_move.append(_squares[from_cell])
	_last_move.append(_squares[piece.cell])
	for square: Square in _last_move:
		square.set_last_move(true)


func _light(cell: Vector2i, effect: String) -> void:
	var square: Square = _squares[cell]
	square.set_effect(effect)
	_lit.append(square)


func _clear() -> void:
	for square: Square in _lit:
		square.set_effect("none")
	_lit.clear()

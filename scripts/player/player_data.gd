class_name PlayerData
extends RefCounted

signal move_requested(piece: Piece, to_cell: Vector2i)
signal piece_removed(piece: Piece)

var is_white: bool
var pieces: Array[Piece] = []

func _init(white: bool) -> void:
	is_white = white

func add_pieces(new_pieces: Array[Piece]) -> void:
	pieces.append_array(new_pieces)

func remove_piece(piece: Piece) -> void:
	pieces.erase(piece)
	piece_removed.emit(piece)

func request_move(piece: Piece, to_cell: Vector2i) -> void:
	if piece in pieces:
		move_requested.emit(piece, to_cell)

func has_won() -> bool:
	return pieces.is_empty()

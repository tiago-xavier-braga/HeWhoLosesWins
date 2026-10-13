class_name PiecesSpawner
extends Node

@export var piece_scene: PackedScene


func spawn_pieces(player: PlayerData, cells: Array[Vector2i], cell_size: Vector2,
		parent: Node2D) -> void:
	var pieces: Array[Piece] = []
	for cell: Vector2i in cells:
		pieces.append(_spawn_piece(cell, cell_size, player.is_white, parent))
	player.add_pieces(pieces)


func _spawn_piece(cell: Vector2i, cell_size: Vector2, is_white: bool, parent: Node2D) -> Piece:
	var piece: Piece = piece_scene.instantiate()
	piece.position = (Vector2(cell) + Vector2(0.5, 0.5)) * cell_size
	piece.cell = cell
	piece.initialize(is_white)
	parent.add_child(piece)
	return piece

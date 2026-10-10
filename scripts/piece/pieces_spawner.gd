class_name PiecesSpawner
extends Node

@export var piece_scene: PackedScene

func spawn_pieces(cells: Array, cell_size: Vector2, is_white: bool) -> Array[Piece]:
    var pieces: Array[Piece] = []
    for cell in cells:
        pieces.append(spawn_piece(cell, cell_size, is_white))
    return pieces

func spawn_piece(cell: Vector2i, cell_size: Vector2, is_white: bool) -> Piece:
    var piece: Piece = piece_scene.instantiate()
    var new_position: Vector2 = Vector2(cell.x * cell_size.x, cell.y * cell_size.y)
    piece.position = new_position
    piece.initialize(is_white)
    add_child(piece)
    return piece
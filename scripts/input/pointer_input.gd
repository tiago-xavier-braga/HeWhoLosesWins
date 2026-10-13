class_name PointerInput
extends Node

var player: PlayerData

var _board: Node2D
var _square_size: Vector2
var _board_size: int
var _selected: Piece


func initialize(player_data: PlayerData, board_spawner: BoardSpawner) -> void:
	player = player_data
	_board = board_spawner.board
	_square_size = board_spawner.square_size
	_board_size = board_spawner.board_size


func _unhandled_input(event: InputEvent) -> void:
	var click: InputEventMouseButton = event as InputEventMouseButton
	if click == null or not click.pressed or click.button_index != MOUSE_BUTTON_LEFT:
		return

	var cell: Vector2i = Vector2i((_board.get_local_mouse_position() / _square_size).floor())
	if cell.x < 0 or cell.y < 0 or cell.x >= _board_size or cell.y >= _board_size:
		_selected = null
		return

	var piece: Piece = _find_piece(cell)
	if piece != null:
		_selected = piece
	elif _selected != null:
		player.request_move(_selected, cell)
		_selected = null


func _find_piece(cell: Vector2i) -> Piece:
	for piece: Piece in player.pieces:
		if piece.cell == cell:
			return piece
	return null

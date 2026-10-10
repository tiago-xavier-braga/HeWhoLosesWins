extends Node

@export var board_scene: PackedScene
@export var square_scene: PackedScene

@export var light_color: Color = Color(1, 1, 1, 1)
@export var dark_color: Color = Color(0, 0, 0, 1)

@export var board_size: int = 8

@export var margin: float = 0.05

var _board: Node2D
var _square_size: Vector2 = Vector2.ZERO


func _ready() -> void:
	_board = board_scene.instantiate()
	add_child(_board)

	var sample_square: Square = square_scene.instantiate()
	_square_size = sample_square.background.texture.get_size()
	sample_square.free()

	for y: int in board_size:
		for x: int in board_size:
			_board.add_child(_create_square(Vector2i(x, y)))

	_fit_board()


func _create_square(cell: Vector2i) -> Square:
	var square: Square = square_scene.instantiate()
	square.position = Vector2(cell) * _square_size
	square.initialize(cell, light_color if (cell.x + cell.y) % 2 == 0 else dark_color)
	return square


func _fit_board() -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var board_pixels: float = _square_size.x * board_size
	var fit_scale: float = minf(viewport_size.x, viewport_size.y) / board_pixels * (1.0 - margin)
	var scaled_pixels: float = board_pixels * fit_scale

	_board.scale = Vector2(fit_scale, fit_scale)
	_board.position = (viewport_size - Vector2(scaled_pixels, scaled_pixels)) / 2.0

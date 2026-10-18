class_name BoardSpawner
extends Node

const FILES: String = "abcdefgh"
const BASE_WIDTH_SETTING: String = "display/window/size/viewport_width"

@export var board_scene: PackedScene
@export var square_scene: PackedScene

@export var light_color: Color = Color(1, 1, 1, 1)
@export var dark_color: Color = Color(0, 0, 0, 1)

@export var board_size: int = 8

@export var margin: float = 0.05

var board: Node2D
var squares: Dictionary[Vector2i, Square] = {}
var square_size: Vector2 = Vector2.ZERO


func initialize() -> void:
	board = board_scene.instantiate()
	add_child(board)

	var sample_square: Square = square_scene.instantiate()
	square_size = sample_square.background.texture.get_size()
	sample_square.free()

	for y: int in board_size:
		for x: int in board_size:
			board.add_child(_create_square(Vector2i(x, y)))

	_fit_board()
	get_viewport().size_changed.connect(_fit_board)


func _create_square(cell: Vector2i) -> Square:
	var square: Square = square_scene.instantiate()
	square.position = Vector2(cell) * square_size
	squares[cell] = square
	var light: bool = (cell.x + cell.y) % 2 == 0
	square.initialize(cell, light_color if light else dark_color)
	# Drawn in the other square's color, so they read on both without a new color.
	var rank: String = str(board_size - cell.y) if cell.x == 0 else ""
	var file: String = FILES[cell.x] if cell.y == board_size - 1 else ""
	square.set_coordinates(rank, file, dark_color if light else light_color)
	return square


# Fitted to the base width, not the screen: the HUD is laid out for that width, so the board
# keeps its size on wider screens and stays between the player bars.
func _fit_board() -> void:
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var base_width: float = float(ProjectSettings.get_setting(BASE_WIDTH_SETTING))
	var board_pixels: float = square_size.x * board_size
	var fit_scale: float = base_width / board_pixels * (1.0 - margin)
	var scaled_pixels: float = board_pixels * fit_scale

	board.scale = Vector2(fit_scale, fit_scale)
	board.position = (viewport_size - Vector2(scaled_pixels, scaled_pixels)) / 2.0

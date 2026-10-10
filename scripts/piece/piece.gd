class_name Piece
extends Node

@export var piece_sprite: Sprite2D
@export var crown_sprite: Sprite2D

@export var white_piece: Color = Color(1, 1, 1, 1)
@export var black_piece: Color = Color(0, 0, 0, 1)
@export var white_crown: Color = Color(1, 1, 1, 1)
@export var black_crown: Color = Color(0, 0, 0, 1)

var _is_checker: bool = false
var _is_white: bool = false

func initialize(is_white: bool) -> void:
	_is_white = is_white
	piece_sprite.modulate = white_piece if _is_white else black_piece
	crown_sprite.visible = false
	crown_sprite.modulate = white_crown if _is_white else black_crown

func set_checker() -> void:
	_is_checker = true
	crown_sprite.visible = true
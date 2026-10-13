class_name Piece
extends Node2D

@export var piece_sprite: Sprite2D
@export var crown_sprite: Sprite2D

@export var white_texture: Texture2D
@export var black_texture: Texture2D
@export var white_crown: Color = Color("2b3f4d")
@export var black_crown: Color = Color("f5f1e6")

var _is_checker: bool = false
var _is_white: bool = false

func initialize(is_white: bool) -> void:
	_is_white = is_white
	piece_sprite.texture = white_texture if _is_white else black_texture
	crown_sprite.visible = false
	crown_sprite.modulate = white_crown if _is_white else black_crown

func set_checker() -> void:
	_is_checker = true
	crown_sprite.visible = true
class_name Piece
extends Node2D

@export var piece_sprite: Sprite2D
@export var crown_sprite: Sprite2D

@export var white_texture: Texture2D
@export var black_texture: Texture2D
@export var white_crown: Color = Color("2b3f4d")
@export var black_crown: Color = Color("f5f1e6")

var cell: Vector2i = Vector2i.ZERO
var is_white: bool = false
var is_checker: bool = false

func initialize(white: bool) -> void:
	is_white = white
	piece_sprite.texture = white_texture if is_white else black_texture
	crown_sprite.visible = false
	crown_sprite.modulate = white_crown if is_white else black_crown

func set_checker() -> void:
	is_checker = true
	crown_sprite.visible = true
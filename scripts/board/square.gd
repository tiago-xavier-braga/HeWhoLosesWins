class_name Square
extends Node2D

@export var background: Sprite2D
@export var effect_sprite: Sprite2D

@export var selected_square: Texture2D
@export var move_hint: Texture2D
@export var capture_hint: Texture2D

var _cell: Vector2i = Vector2i.ZERO

func initialize(cell: Vector2i, color: Color) -> void:
	_cell = cell
	background.modulate = color
	set_effect("none")

func set_effect(effect: String) -> void:
	match effect:
		"selected":
			effect_sprite.texture = selected_square
		"move_hint":
			effect_sprite.texture = move_hint
		"capture_hint":
			effect_sprite.texture = capture_hint
		"none":
			effect_sprite.texture = null
		_:
			effect_sprite.texture = null
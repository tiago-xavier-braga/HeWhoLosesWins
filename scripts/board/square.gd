class_name Square
extends Node2D

@export var background: Sprite2D
@export var effect_sprite: Sprite2D
# Its own sprite, so clearing the hints never clears the last move.
@export var last_move_sprite: Sprite2D
@export var rank_label: Label
@export var file_label: Label

@export var selected_square: Texture2D
@export var move_hint: Texture2D
@export var capture_hint: Texture2D

var _cell: Vector2i = Vector2i.ZERO

func initialize(cell: Vector2i, color: Color) -> void:
	_cell = cell
	background.modulate = color
	set_effect("none")

func set_coordinates(rank: String, file: String, color: Color) -> void:
	rank_label.text = rank
	file_label.text = file
	rank_label.add_theme_color_override("font_color", color)
	file_label.add_theme_color_override("font_color", color)

func set_last_move(on: bool) -> void:
	last_move_sprite.visible = on

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
class_name PlayerBar
extends Control

@export var background: Panel
@export var avatar: TextureRect
@export var name_label: Label
@export var tag_label: Label
@export var status: Control
@export var status_label: Label
@export var pips: HBoxContainer
@export var pip_template: TextureRect
@export var count_label: Label
@export var count_caption: Label
@export var white_texture: Texture2D
@export var black_texture: Texture2D
@export var pip_on: Texture2D
@export var pip_off: Texture2D
@export var idle_style: StyleBox
@export var active_style: StyleBox

var _player: PlayerData
var _pips: Array[TextureRect] = []
var _counts_pieces: bool = true


# One pip per starting piece; the goal is to lose them all, so the empty ones are progress.
func initialize(player: PlayerData, player_name: String, tag: String) -> void:
	_player = player
	name_label.text = player_name
	tag_label.text = tag
	tag_label.visible = not tag.is_empty()
	avatar.texture = white_texture if player.is_white else black_texture
	for _index: int in player.pieces.size():
		var pip: TextureRect = pip_template.duplicate()
		pip.show()
		pips.add_child(pip)
		_pips.append(pip)
	player.piece_removed.connect(_on_piece_removed)
	_refresh()


func set_active(active: bool, status_text: String) -> void:
	background.add_theme_stylebox_override("panel", active_style if active else idle_style)
	status_label.text = status_text
	status.visible = active and not status_text.is_empty()


# Puzzles show the moves left here instead of the pieces left.
func show_counter(value: int, caption: String) -> void:
	_counts_pieces = false
	count_label.text = str(value)
	count_caption.text = caption


func _on_piece_removed(_piece: Piece) -> void:
	_refresh()


func _refresh() -> void:
	var left: int = _player.pieces.size()
	for index: int in _pips.size():
		_pips[index].texture = pip_on if index < left else pip_off
	if _counts_pieces:
		count_label.text = str(left)

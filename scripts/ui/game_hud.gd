class_name GameHud
extends CanvasLayer

const HUMAN_NAME: String = "YOU"
const CPU_NAME: String = "CPU"
const YOUR_TURN_TEXT: String = "YOUR TURN"
const MUST_CAPTURE_TEXT: String = "MUST CAPTURE!"
const MOVES_LEFT_TEXT: String = "MOVES LEFT"

@export var mode_label: Label
@export var opponent_bar: PlayerBar
@export var player_bar: PlayerBar
# A path, because the menu scene already references the game scene that contains this HUD.
@export_file("*.tscn") var menu_scene_path: String = "res://scenes/ui/main_menu.tscn"

var _human: PlayerData
var _piece_mover: PieceMover


func initialize(human: PlayerData, cpu: PlayerData, piece_mover: PieceMover, mode: String,
		cpu_tag: String) -> void:
	_human = human
	_piece_mover = piece_mover
	mode_label.text = mode
	player_bar.initialize(human, HUMAN_NAME, "")
	opponent_bar.initialize(cpu, CPU_NAME, cpu_tag)


# Checked at the start of the turn, so the player knows before trying a piece that can't move.
func on_turn_changed(current: PlayerData) -> void:
	var human_turn: bool = current == _human
	var forced: bool = human_turn and _piece_mover.must_capture(_human)
	player_bar.set_active(human_turn, MUST_CAPTURE_TEXT if forced else YOUR_TURN_TEXT)
	opponent_bar.set_active(not human_turn, "")


func show_moves_left(moves: int) -> void:
	player_bar.show_counter(moves, MOVES_LEFT_TEXT)


func _on_home_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene_path)


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

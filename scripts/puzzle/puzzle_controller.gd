class_name PuzzleController
extends MatchController

const TITLE_TEXT: String = "Puzzle"
const SOLVED_TEXT: String = "SOLVED!"
const FAILED_TEXT: String = "FAILED"
const PUZZLE_MODE_TEXT: String = "PUZZLE %02d"
const LIMIT_TEXT: String = " · LOSE ALL IN %d"

var _player_moves: int = 0


func _ready() -> void:
	win_panel.next_button.pressed.connect(_on_next_pressed)
	super()


func start_match() -> void:
	super()
	_show_moves_left()


# The CPU keeps the difficulty set on CpuPlayer in the scene, so every puzzle uses the same one.
func _set_up_match() -> void:
	var level: PuzzleLevel = GameSettings.puzzle
	var cell_size: Vector2 = board_spawner.square_size
	var parent: Node2D = board_spawner.board
	pieces_spawner.spawn_pieces(players[0], level.player_men, cell_size, parent)
	pieces_spawner.spawn_kings(players[0], level.player_kings, cell_size, parent)
	pieces_spawner.spawn_pieces(players[1], level.cpu_men, cell_size, parent)
	pieces_spawner.spawn_kings(players[1], level.cpu_kings, cell_size, parent)


func _mode_text() -> String:
	var text: String = PUZZLE_MODE_TEXT % (GameSettings.puzzles.find(GameSettings.puzzle) + 1)
	if GameSettings.puzzle.max_moves != PuzzleLevel.NO_LIMIT:
		text += LIMIT_TEXT % GameSettings.puzzle.max_moves
	return text


# Checked when the turn comes back, so the CPU's reply to the last allowed move still counts.
func _set_turn(index: int) -> void:
	if players[index] != cpu_player.player and _is_out_of_moves():
		_finish_match(cpu_player.player)
		return
	super(index)


func _on_piece_moved(piece: Piece, from_cell: Vector2i) -> void:
	if current_player != cpu_player.player:
		_player_moves += 1
		_show_moves_left()
	super(piece, from_cell)


func _finish_match(winner: PlayerData) -> void:
	var level: PuzzleLevel = GameSettings.puzzle
	if winner != cpu_player.player and level not in GameSettings.solved_puzzles:
		GameSettings.solved_puzzles.append(level)
	super(winner)


func _show_result(winner: PlayerData) -> void:
	var solved: bool = winner != cpu_player.player
	win_panel.next_button.visible = solved and _next_level() != null
	win_panel.show_result(TITLE_TEXT, SOLVED_TEXT if solved else FAILED_TEXT, solved)


func _is_out_of_moves() -> bool:
	var max_moves: int = GameSettings.puzzle.max_moves
	return max_moves != PuzzleLevel.NO_LIMIT and _player_moves >= max_moves


func _show_moves_left() -> void:
	var max_moves: int = GameSettings.puzzle.max_moves
	if max_moves != PuzzleLevel.NO_LIMIT:
		hud.show_moves_left(max_moves - _player_moves)


func _next_level() -> PuzzleLevel:
	var index: int = GameSettings.puzzles.find(GameSettings.puzzle)
	if index == -1 or index + 1 >= GameSettings.puzzles.size():
		return null
	return GameSettings.puzzles[index + 1]


func _on_next_pressed() -> void:
	GameSettings.puzzle = _next_level()
	get_tree().reload_current_scene()

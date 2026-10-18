extends Node

## Every sound effect in one place, so any script plays one with `Sfx.play(Sfx.NAME)`.
## See docs/sound_effects.md for when each one plays.

const BUS: StringName = &"SFX"
const PLAYER_COUNT: int = 8

const BUTTON_CLICK: AudioStream = preload("res://assets/audio/sfx_button_click.ogg")
const LOSE: AudioStream = preload("res://assets/audio/sfx_lose.ogg")
const PIECE_MOVE: AudioStream = preload("res://assets/audio/sfx_piece_move.ogg")
const WIN: AudioStream = preload("res://assets/audio/sfx_win.ogg")

var _players: Array[AudioStreamPlayer] = []
var _next: int = 0


# A pool, so a multi-capture's sounds overlap instead of cutting each other off. The players
# live here, outside the scenes, so a button's click survives the scene change it triggers.
func _ready() -> void:
	for _index: int in PLAYER_COUNT:
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.bus = BUS
		add_child(player)
		_players.append(player)
	get_tree().node_added.connect(_on_node_added)


func play(stream: AudioStream, pitch: float = 1.0) -> void:
	var player: AudioStreamPlayer = _players[_next]
	_next = (_next + 1) % PLAYER_COUNT
	player.stream = stream
	player.pitch_scale = pitch
	player.play()


# Every button gets its click here, so no scene has to wire it.
func _on_node_added(node: Node) -> void:
	var button: BaseButton = node as BaseButton
	if button != null:
		button.pressed.connect(play.bind(BUTTON_CLICK))

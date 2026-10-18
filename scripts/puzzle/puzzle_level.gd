class_name PuzzleLevel
extends Resource

## Squares are (column, row). Row 0 is the top row, where the CPU (black) starts;
## the player (white) moves up, toward row 0.

const NO_LIMIT: int = 0

## Moves the player has to lose all their pieces. 0 means no limit.
@export var max_moves: int = NO_LIMIT
@export var player_men: Array[Vector2i] = []
@export var player_kings: Array[Vector2i] = []
@export var cpu_men: Array[Vector2i] = []
@export var cpu_kings: Array[Vector2i] = []

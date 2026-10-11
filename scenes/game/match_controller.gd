class_name MatchController
extends Node

@export var board_spawner: BoardSpawner
@export var pieces_spawner: PiecesSpawner


func _ready() -> void:
    start_match()

func start_match() -> void:
    board_spawner.initialize()
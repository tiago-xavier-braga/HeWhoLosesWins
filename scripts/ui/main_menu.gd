class_name MainMenu
extends Control

@export var game_scene: PackedScene


func _on_difficulty_pressed(difficulty: CpuDifficulty) -> void:
	GameSettings.difficulty = difficulty
	get_tree().change_scene_to_packed(game_scene)

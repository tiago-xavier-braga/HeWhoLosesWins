class_name WinPanel
extends CanvasLayer

@export var dim: ColorRect
@export var title_label: Label
@export var result_label: Label
@export var won_color: Color = Color("4a90c2cc")
@export var lost_color: Color = Color("f07360cc")
# A path, because the menu scene already references the game scene that contains this panel.
@export_file("*.tscn") var menu_scene_path: String = "res://scenes/ui/main_menu.tscn"


func show_result(title: String, result: String, player_won: bool) -> void:
	dim.color = won_color if player_won else lost_color
	title_label.text = title
	result_label.text = result
	show()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene_path)

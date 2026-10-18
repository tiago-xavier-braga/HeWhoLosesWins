class_name WinPanel
extends CanvasLayer

@export var title_label: Label
@export var result_label: Label
# A path, because the menu scene already references the game scene that contains this panel.
@export_file("*.tscn") var menu_scene_path: String = "res://scenes/ui/main_menu.tscn"


func show_result(title: String, result: String) -> void:
	title_label.text = title
	result_label.text = result
	show()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file(menu_scene_path)

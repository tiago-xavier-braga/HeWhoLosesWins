class_name WinPanel
extends CanvasLayer

const MENU_SCENE_PATH: String = "res://scenes/ui/main_menu.tscn"

@export var message_label: Label


func show_winner(player_name: String) -> void:
	message_label.text = "%s wins" % player_name
	show()


func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()


# By path, because the menu scene already references the game scene that contains this panel.
func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE_PATH)

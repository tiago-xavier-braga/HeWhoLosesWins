class_name WinPanel
extends CanvasLayer

@export var message_label: Label


func show_winner(player_name: String) -> void:
	message_label.text = "%s wins" % player_name
	show()

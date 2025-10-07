extends Control


signal start_level_one


func start_game() -> void:
	start_level_one.emit()

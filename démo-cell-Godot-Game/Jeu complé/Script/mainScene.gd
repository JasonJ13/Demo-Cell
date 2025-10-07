extends Control

@onready var menu = $Menu

var level_preload = preload("res://Jeu complé/Level 1.tscn")

var level

func start_level_one() -> void:
	menu.hide()
	menu.process_mode = Node.PROCESS_MODE_DISABLED

	level = level_preload.instantiate()
	
	level.level_finished.connect(level_end)
	
	add_child(level)


func level_end() -> void :
	menu.show()
	menu.process_mode = Node.PROCESS_MODE_ALWAYS

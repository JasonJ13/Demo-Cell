extends Node2D
class_name Level

var nmb_fruit_total = 0
var nmb_fruit_collected = 0

signal level_finished

@onready var player : CharacterBody2D = $Player

func _ready() :
	for fruit in $Fruit.get_children() :
		nmb_fruit_total += 1
		fruit.collected.connect(fruit_collected)
	
	player.init_fruit(nmb_fruit_total)

func get_nmb_fruit() -> int:
	return nmb_fruit_total

func fruit_collected() -> void:
	nmb_fruit_collected += 1
	
	if nmb_fruit_collected == nmb_fruit_total :
		level_finished.emit()
		
		queue_free()

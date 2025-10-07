extends Control

@onready var label_nmb_fruit = $nmb_fruit
var nmb_fruit_collected
var nmb_fruit_total


func update_label() -> void :
	label_nmb_fruit.text = str(nmb_fruit_collected) + "/" + str(nmb_fruit_total)

func init_fruit(nmb_fruit : int) -> void :
	nmb_fruit_collected = 0
	nmb_fruit_total = nmb_fruit
	update_label()

func new_fruit() -> void :
	nmb_fruit_collected += 1
	update_label()

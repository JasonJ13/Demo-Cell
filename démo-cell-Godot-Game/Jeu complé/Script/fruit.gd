extends StaticBody2D
class_name Fruit

@onready var sprite : AnimatedSprite2D = $Sprite
@onready var timer_death : Timer = $Timer
@onready var sound_collected : AudioStreamPlayer2D = $SoundEffects

signal collected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var skin = randi() % 4
	
	match skin :
		0 :
			sprite.play("Apple")
		1 :
			sprite.play("Banana")
		2 :
			sprite.play("Cherry")
		3 :
			sprite.play("Kiwi")

func disapear() -> void :
	collision_mask = 0
	collision_layer = 0
	sprite.play("Disapear")
	sound_collected.play()
	collected.emit()
	timer_death.start()

func end() -> void:
	queue_free()

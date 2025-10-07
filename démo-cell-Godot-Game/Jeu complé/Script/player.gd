extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY : float= -400.0



var side : int = 1  	#  1 = left -> right | -1 = right -> left
var double_jump : bool = true

@onready var sprite : AnimatedSprite2D = $Sprite
@onready var timer_jump : Timer = $Jump
@onready var timer_off_platform : Timer = $off_platform
@onready var interface : Control = $Camera2D/Interface

func init_fruit(nmb_fruit) :
	interface.init_fruit(nmb_fruit)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if side * velocity.x < 0 :
		side = side * -1
		sprite.flip_h = !sprite.flip_h


	if is_on_floor() || !timer_off_platform.is_stopped():
		
		if is_on_floor() :
			
			timer_off_platform.start()
		
		double_jump = true
		if velocity != Vector2(0,0) :
			sprite.animation = "running"
	
		else :
			sprite.animation = "standing"
		
		if Input.is_action_just_pressed("Jump") :
			timer_jump.start()
			velocity.y +=  JUMP_VELOCITY
			

	else :
		
		if Input.is_action_just_pressed("Jump") && double_jump && timer_jump.is_stopped():
			velocity.y =JUMP_VELOCITY
			double_jump = false
			sprite.play("double_jump")
		
		
		if sprite.animation != "double_jump" || !sprite.is_playing() :
			if velocity.y > 0 :
				sprite.play("jump")
			
			elif velocity.y < 60 :
				sprite.play("fall")


	move_and_slide()


func collision(body: Node2D) -> void:
	
	if body is Fruit :
		interface.new_fruit()
		body.disapear()


func initiat_animation() :
	sprite.play("appearing")

extends CharacterBody2D

const COYOTE_TIME = 0.10 # still jumpable after leasving a ledge
const JUMP_BUFFER = 0.10 # a press just before landing that still counts
const SPEED = 130.0
const ACCELERATION = 1300.0
const FRICTION = 1600.0
const AIR_ACCELERATION = 900.0
const AIR_FRICTION = 350.0
const JUMP_VELOCITY = -300.0
var coyote_timer: float = 0.0
var jump_buffer_timer: float = 0.0
@onready var animated_sprite = $AnimatedSprite2D


func _handle_horizontal(delta):
	var direction := Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		var accel := ACCELERATION if is_on_floor() else AIR_ACCELERATION
		velocity.x = move_toward(velocity.x, direction * SPEED, accel * delta)
	else:
		var fric := FRICTION if is_on_floor() else AIR_FRICTION
		velocity.x = move_toward(velocity.x, 0.0, fric * delta)
	
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	
	

extends CharacterBody2D
var WasOnGround = false
var LastVelocity = Vector2.ZERO
const SPEED = 200.0
const JUMP_VELOCITY = -800 
const BOUNCE_FORCE = 500.0 # How hard the player is pushed back
func _physics_process(delta: float) -> void:
	if is_on_floor() and not WasOnGround and LastVelocity.y > 700:
		if randf() < 0.1:
			velocity.x = velocity.x + randf_range(-0.5, 0.5) * LastVelocity.y
		velocity.y = LastVelocity.y *-randf_range(0.5, 0.2)
	if not is_on_floor():
		velocity += get_gravity() * delta 
	if is_on_floor() && Input.is_action_just_pressed("jumping"):
		velocity.y += JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("moving left ", "moving right")
	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else: 
		velocity.x = velocity.x + direction * delta * 100
	WasOnGround = is_on_floor()
	LastVelocity = velocity
	move_and_slide()

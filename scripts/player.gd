class_name Player extends CharacterBody2D

@onready var body = $"."

@onready var checkpoint:Vector2
const SPEED = 170.0
const JUMP_VELOCITY = -250

# Switch SFX
@onready var offSFX = $Off
@onready var onSFX = $On

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	checkpoint = body.global_transform.origin

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_main_coll_changed():
	var current_layer = body.collision_layer
	var current_mask = body.collision_mask

	if current_layer == 1:
		body.collision_layer = 2
	elif current_layer == 2:
		body.collision_layer = 1

	if current_mask == 1:
		body.collision_mask = 2
	elif current_mask == 2:
		body.collision_mask = 1
	
	if current_mask == 1:
		onSFX.play()
	elif current_layer == 2: 
		offSFX.play()
	



func _on_checkpoint_body_entered(body):
	if body is Player:
		checkpoint = body.global_transform.origin
		print(checkpoint)

func _on_death_area_body_entered(body):
	if body is Player:
		body.global_transform.origin = checkpoint 
		print("DEATH")
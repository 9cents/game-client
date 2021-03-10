extends KinematicBody2D

const ACCELERATION = 700
const FRICTION = 700
const MAX_SPEED = 400

var velocity = Vector2.ZERO
var animationPlayer = null

func _ready():
		
	animationPlayer = $AnimationPlayer


func _physics_process(delta):
	
	var input_vec = Vector2.ZERO
	
	input_vec.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vec.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vec = input_vec.normalized()
	
	if input_vec != Vector2.ZERO:
		if input_vec.x > 0:
			animationPlayer.play("Right")
		else:
			animationPlayer.play("Left")
		velocity = velocity.move_toward(input_vec * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
		

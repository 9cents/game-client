extends Area2D

var id

export var speed = 300
var screen_size
var velocity = Vector2()

signal hit(value, other_value)

func start(i):
	position.x = randi() % (int(screen_size.x)-80) +  40
	position.y = randi() % (int(screen_size.y*0.6)-60) + int(screen_size.y*0.4) + 30
	velocity.x = 0
	velocity.y = 0
	id = i
	
func _ready():
	$AnimatedSprite.animation = "respawn"
	$AnimatedSprite.play()
	$CollisionShape2D.set_deferred("disabled", false)
	screen_size = get_viewport_rect().size

func _process(delta):
	if position.x>=screen_size.x-30:
		velocity.x = -randi()%9+1
	if position.x<= 30:
		velocity.x = randi()%9+1
	if position.y>= screen_size.y-30:
		velocity.y = -randi()%9+1
	if position.y<= screen_size.y*0.4 + 30:
		velocity.y = randi()%9+1
	velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position.x = clamp(position.x, 30, screen_size.x-30)
	position.y = clamp(position.y, screen_size.y*0.4 + 30 , screen_size.y-30)
	
	$AnimatedSprite.flip_h = velocity.x < 0

func end():
	hide()
	queue_free()

func _on_Enemy_area_entered(area):
	emit_signal("hit", id)
	hide()
	$CollisionShape2D.set_deferred("disabled", true)

func start_moving():
	move()
	$Label.text= char(65+id)
	
	#var mob_types = $AnimatedSprite.frames.get_animation_names()
	$CollisionShape2D.set_deferred("disabled", false)
	#$AnimatedSprite.animation = mob_types[randi() % (mob_types.size()-1)+1]
	$AnimatedSprite.animation = "wormwalk"
	$AnimatedSprite.play()

func move():
	$AnimatedSprite.animation = "wormwalk"
	$AnimatedSprite.play()
	velocity.x = randi() % 9 + 1
	velocity.y = randi() % 9 + 1
	if randi()%2:
		velocity.x = -velocity.x
	if randi()%2:
		velocity.y = -velocity.y

func freeze():
	$AnimatedSprite.animation = "respawn"
	$AnimatedSprite.play()
	velocity.x = 0
	velocity.y = 0

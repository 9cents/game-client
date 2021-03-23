extends Area2D

var char_type = Main.char_name
var ulti_time
var cooldown_time

export var speed = 400  
var screen_size 

signal freeze
signal defreeze

#Set special skill time and cooldown time 
var ulti_dict = {
	'mage': {
		'ulti_time' : 2,
		'cd_time' : 6
	},
	'ninja': {
		'ulti_time' : 4,
		'cd_time' : 6
	},
	'knight': {
		'ulti_time' : 3,
		'cd_time' : 6
	}
}

func start(pos):
	position = pos
	show()
	ulti_time = 3
	cooldown_time = 3
	$AnimatedSprite.animation = char_type
	$CollisionShape2D.disabled = true
	$UltiTimer.wait_time = ulti_dict[char_type]['ulti_time']
	$CooldownTimer.wait_time = ulti_dict[char_type]['cd_time']

func _ready():
	screen_size = get_viewport_rect().size
	hide()

#Perform special skill base on chosen character
func input():
	if $UltiTimer.is_stopped() and $CooldownTimer.is_stopped():
		if char_type == 'mage':
			emit_signal("freeze")
		if char_type == 'ninja':
			speed = 700
		if char_type == 'knight':
			make_collidable(false)
		$AnimatedSprite.animation = char_type
		$AnimatedSprite.play()
		$UltiTimer.start()

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_key_pressed(KEY_SHIFT):
		input()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	elif char_type && $AnimatedSprite.animation == "attack_"+char_type:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 30, screen_size.x-30)
	position.y = clamp(position.y, screen_size.y*0.4+30, screen_size.y-30)
	
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0
		
	if $UltiTimer.is_stopped() and $CooldownTimer.is_stopped():
		$Label.text = 'Press Shift'
	elif !$UltiTimer.is_stopped():
		$Label.text = str(int($UltiTimer.time_left)+1)
	elif !$CooldownTimer.is_stopped():
		$Label.text = 'cooling down ' + str(int($CooldownTimer.time_left)+1)
	
	# HANDLE SLASHING ANIMATION
	if char_type && $AnimatedSprite.animation == "attack_"+char_type && $AnimatedSprite.frame == $AnimatedSprite.frames.get_frame_count("attack_"+char_type)-1:
			$AnimatedSprite.animation = char_type
			$AnimatedSprite.play()

func make_collidable(is_collidable: bool):
	$CollisionShape2D.set_deferred("disabled", !is_collidable)

#Character Special skill timer and cooldown timer 
func _on_UltiTimer_timeout():
	$UltiTimer.stop()
	$CooldownTimer.start()
	if char_type=='mage':
		emit_signal("defreeze")
	if char_type=='ninja':
		speed = 400
	if char_type=='knight':
		make_collidable(true)
	$AnimatedSprite.animation = char_type
	$AnimatedSprite.play()


func _on_CooldownTimer_timeout():
	$CooldownTimer.stop()

#Player collision 
func _on_Player_area_entered(area):
	if $UltiTimer.is_stopped():
		$AnimatedSprite.animation = "attack_"+char_type
		$AnimatedSprite.play()

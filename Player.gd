extends Area2D

signal pickup
signal die
signal collision

func _ready():
	pass # Replace with function body.

export (int) var speed
var velocity = Vector2()
var window_size = Vector2(1024, 600)
var window_margin = 50

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"

#func get_input():
#	velocity = Vector2()
#	if Input.is_action_pressed("ui_left"):
#		velocity.x -= 1
#	if Input.is_action_pressed("ui_right"):
#		velocity.x += 1
#	if Input.is_action_pressed("ui_up"):
#		velocity.y -= 1
#	if Input.is_action_pressed("ui_down"):
#		velocity.y += 1
#	if velocity.length() > 0:
#		velocity = velocity.normalized() * speed

func _process(delta):
#	get_input()

	position += velocity * delta * 0.5
	position.x = clamp(position.x, 0, window_size.x)
	position.y = clamp(position.y, 0, window_size.y)

	if velocity.length() > 0:
		$AnimatedSprite.animation = "walk"
#		$AnimatedSprite.flip_h = (velocity.x < 0)
	else:
		$AnimatedSprite.animation = "idle"
	
	if (position.x<window_margin)||(position.y<window_margin)||(position.x>window_size.x-window_margin)||(position.y>window_size.y-window_margin-105):
		emit_signal("collision")

func die():
	$AnimatedSprite.animation = "die"
	set_process(false)

func _on_Player_area_entered(area):
	if area.is_in_group("coins"):
		emit_signal("pickup")
		area.pickup()

#func _on_TouchScreenButton_pressed():

func _on_HUD_button_down():
	velocity = Vector2()
	velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func _on_HUD_button_left():
	velocity = Vector2()
	velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func _on_HUD_button_right():
	velocity = Vector2()
	velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

func _on_HUD_button_up():
	velocity = Vector2()
	velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

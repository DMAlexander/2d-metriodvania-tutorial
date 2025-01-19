extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY = 1000
const SPEED = 300
const JUMP = -300
const JUMP_HORIZONTAL = 100

enum State { Idle, Run, Jump }

var current_state

func _ready():
	current_state = State.Idle
	
	
func _physics_process(delta):
	player_falling(delta)
	player_idle(delta)
	player_run(delta)
	player_jump(delta)
	
	move_and_slide()
	
	player_animations()
	
	
func player_falling(delta):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		
		
func player_idle(delta):
	if is_on_floor():
		current_state = State.Idle
		
		
func player_run(delta):
	if !is_on_floor():
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction != 0:
		current_state = State.Run
		animated_sprite_2d.flip_h = false if direction > 0 else true
		
		
func player_jump(delta):
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP
		current_state = State.Jump
		
	if !is_on_floor() and current_state == State.Jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * JUMP_HORIZONTAL * delta

func player_animations():
	print("Current State: ", current_state)
	if current_state == State.Idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.Run:
		animated_sprite_2d.play("run")
	elif current_state == State.Jump:
		animated_sprite_2d.play("jump")

#var bullet = preload("res://player/bullet.gd")
#var player_death_effect = preload("res://player/player_death_effect/player_death_effect.tscn")
#
#@onready var animated_sprite_2d = $AnimatedSprite2D
#@onready var muzzle: Marker2D = $Muzzle
#
#
#func player_death():
	#var player_death_effect_instance = player_death_effect.instantiate() as Node2D
	#player_death_effect_instance.global_position = global_position
	#get_parent().add_child(player_death_effect_instance)
	#queue_free()
	#
#
#func _on_hurtbox_body_entered(body: Node2D):
	#if body.is_in_group("Enemy"):
		#print("Enemy entered ", body.damage_amount)
		#
		#var tween = get_tree().create_tween()
		#tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", true, 0)
		#tween.tween_property(animated_sprite_2d, "material:shader_parameter/enabled", false, 0.2)
#
		#HealthManager.decrease_health(body.damage_amount)
		#
	#if HealthManager.current_health == 0:
		#player_death()

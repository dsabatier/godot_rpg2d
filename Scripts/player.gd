class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

@export var frames: SpriteFrames

var _no_input = false;

func _ready():
	sprite.sprite_frames = frames
	sprite.position = Vector2(0, 0)

	global_position = SceneManager.get_entrance_position()

	#_no_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").length_squared() > 0

func _physics_process(_delta: float) -> void:
	if(_no_input):
		_no_input = Input.get_vector("move_left", "move_right", "move_up", "move_down").length_squared() > 0
		return
		

	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * SPEED
	
	if(velocity.length_squared() > 0):
		sprite.play()
	else:
		sprite.stop()
		return

	if(velocity.x < 0):
		sprite.animation = "move_left"
	elif(velocity.x > 0):
		sprite.animation = "move_right"
	elif(velocity.y < 0):
		sprite.animation = "move_up"
	elif(velocity.y > 0):
		sprite.animation = "move_down"
	else:
		sprite.stop()

	move_and_slide()

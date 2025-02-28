class_name Player
extends CharacterBody2D

enum FacingDirection { UP, DOWN, LEFT, RIGHT }

@export var SPEED = 100.0

@onready var sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

@export var frames: SpriteFrames

var _no_input = false;

func _ready():
	sprite.sprite_frames = frames
	sprite.position = Vector2(0, 0)

	SceneManager.init_player(self)

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

	var collision = get_last_slide_collision()

	if(collision and collision.get_collider().has_signal("player_collision")):
		collision.get_collider().emit_signal("player_collision", collision.get_normal())
		
	move_and_slide()


func get_facing_direction() -> FacingDirection:
	if(sprite.animation == "move_left"):
		return FacingDirection.LEFT
	elif(sprite.animation == "move_right"):
		return FacingDirection.RIGHT
	elif(sprite.animation == "move_up"):
		return FacingDirection.UP
	elif(sprite.animation == "move_down"):
		return FacingDirection.DOWN
	else:
		return FacingDirection.DOWN

func set_facing_direction(direction: FacingDirection) -> void:
	match direction:
		FacingDirection.UP:
			sprite.animation = "move_up"
		FacingDirection.DOWN:
			sprite.animation = "move_down"
		FacingDirection.LEFT:
			sprite.animation = "move_left"
		FacingDirection.RIGHT:
			sprite.animation = "move_right"
		_:
			sprite.animation = "move_down"
extends RigidBody2D

signal player_collision(normal: Vector2)

@export var push_speed: float = 25

# connect a signal to the player_collision signal
func _ready():
    connect("player_collision", _on_player_collision)

func _on_player_collision(normal: Vector2) -> void:
    apply_central_force(-normal * push_speed)
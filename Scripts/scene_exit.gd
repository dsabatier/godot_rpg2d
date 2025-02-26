extends Area2D

@export var next_scene: String
@export var entrance_index : int = 0

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		SceneManager.go_to_scene(next_scene, entrance_index)

extends Area2D

var on_top : int = 0

func _on_body_entered(body:Node2D) -> void:
	if body is Player or body.is_in_group("block"):
		on_top += 1
		if on_top == 1:
			$AnimatedSprite2D.animation = "pressed"
			$AnimatedSprite2D.play()


func _on_body_exited(body: Node2D) -> void:
	if body is Player or body.is_in_group("block"):
		on_top -= 1
		if on_top == 0:
			$AnimatedSprite2D.animation = "unpressed"
			$AnimatedSprite2D.play()

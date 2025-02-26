extends Node

var _cached_index : int = -1

func go_to_scene(scene_path: String, entrance_index: int) -> void:
	_cached_index = entrance_index
	get_tree().change_scene_to_file.call_deferred(scene_path)

func get_entrance_position() -> Vector2:
	var entrances : Node = get_tree().get_first_node_in_group("entrance_collection")

	if entrances:
		return entrances.get_children()[_cached_index].global_position
	else:
		return Vector2.ZERO

func get_cached_position() -> int:
	return _cached_index


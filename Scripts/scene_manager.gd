extends Node

var _cached_index : int = -1
var _cached_facing : Player.FacingDirection = Player.FacingDirection.DOWN

func go_to_scene(scene_path: String, entrance_index: int, facing_direction: Player.FacingDirection) -> void:
	_cached_index = entrance_index
	_cached_facing = facing_direction
	get_tree().change_scene_to_file.call_deferred(scene_path)

func init_player(player : Player) -> void:
	var entrances : Node = get_tree().get_first_node_in_group("entrance_collection")
	player.set_facing_direction(_cached_facing)
	if entrances:
		player.global_position = entrances.get_children()[_cached_index].global_position

func get_cached_position() -> int:
	return _cached_index

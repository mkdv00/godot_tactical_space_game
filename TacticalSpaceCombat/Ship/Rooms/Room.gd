tool
class_name ShipRoom
extends Area2D

export var size := Vector2.ONE setget set_size

var _area := 0
var _top_left := Vector2.ZERO
var _bottom_right := Vector2.ZERO

var _iter_index := 0

var _tilemap: TileMap = null

onready var collision_shape: CollisionShape2D = $CollisionShape2D
onready var feedback: NinePatchRect = $Feedback


func setup(tilemap: TileMap) -> void:
	_tilemap = tilemap
	_setup_extents()

	_area = size.x * size.y
	_top_left = _tilemap.world_to_map(position - collision_shape.shape.extents)
	_bottom_right = _top_left + size

	feedback.rect_position -= collision_shape.shape.extents
	feedback.rect_size = 2 * collision_shape.shape.extents


func _setup_extents() -> void:
	if _tilemap != null:
		collision_shape.shape.extents = 0.5 * _tilemap.map_to_world(size)


func _ready() -> void:
	connect("mouse_entered", self, "_on_mouse_entered_exited", [true])
	connect("mouse_exited", self, "_on_mouse_entered_exited", [false])


func _on_mouse_entered_exited(has_entered: bool) -> void:
	feedback.visible = has_entered
	var group := "selected-room"
	if has_entered:
		add_to_group(group)
	elif is_in_group(group):
		remove_from_group(group)


func set_size(value: Vector2) -> void:
	for axis in [Vector2.AXIS_X, Vector2.AXIS_Y]:
		size[axis] = max(1, value[axis])
	_setup_extents()


func _iter_init(_arg) -> bool:
	_iter_index = 0
	return _iter_is_running()


func _iter_next(_arg) -> bool:
	_iter_index += 1
	return _iter_is_running()


func _iter_get(_arg) -> Vector2:
	var offset := Utils.index_to_xy(size.x, _iter_index)
	return _top_left + offset


func _iter_is_running() -> bool:
	return _iter_index < _area

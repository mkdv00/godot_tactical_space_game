tool
extends Node2D

onready var tile_map: TileMap = $TileMap
onready var rooms: Node2D = $Rooms
onready var units: Node2D = $Units


func _ready() -> void:
	call("_ready_editor_hint" if Engine.editor_hint else "_ready_not_editor_hint")


func _ready_editor_hint() -> void:
	for room in rooms.get_children():
		if room is ShipRoom:
			room.setup(tile_map)


func _ready_not_editor_hint() -> void:
	for room in rooms.get_children():
		if room is ShipRoom:
			room.setup(tile_map)
			
			for point in room:
				tile_map.set_cellv(point, 0)
	tile_map.update_bitmask_region()

extends Node2D

const UIUnit = preload("res://TacticalSpaceCombat/UI/UIUnit.tscn")

onready var ship_player: Node2D = $ShipPlayer
onready var ui_units: VBoxContainer = $UI/Units


func _ready() -> void:
	_ready_units()


func _ready_units() -> void:
	for unit in ship_player.units.get_children():
		var ui_unit: ColorRect = UIUnit.instance()
		ui_units.add_child(ui_unit)
		unit.setup(ui_unit)

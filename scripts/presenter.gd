extends Node2D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()

@onready var defender_slot: ColorRect = $DefenderSlot
@onready var lane_end: ColorRect = $LaneEnd

func _ready() -> void:
	$SheetLens.make_current()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		if rules.placed:
			if rules.sell(true) == "sold":
				defender_slot.color = Color(0.4, 0.4, 0.45)
		else:
			var outcome := rules.try_place(true)
			if outcome == "placed":
				defender_slot.color = Color(0.2, 0.7, 0.3)
	if event.is_action_pressed("leap"):
		rules.march()
		if rules.leaked:
			lane_end.color = Color(0.8, 0.2, 0.2)
		elif rules.may_bend():
			_go("res://scenes/bend.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)

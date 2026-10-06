extends RefCounted

var purse := 10
const COST := 4
var placed := false
var leaked := false

func try_place(on_lane: bool) -> String:
	if not on_lane:
		return "off_lane"
	if purse < COST:
		return "broke"
	purse -= COST
	placed = true
	return "placed"

func march() -> void:
	if not placed:
		leaked = true

func reset_lane() -> void:
	purse = 10
	placed = false
	leaked = false

func sell(is_placed: bool) -> String:
	if not is_placed:
		return "rejected"
	purse += int(COST / 2)
	placed = false
	return "sold"

func may_bend() -> bool:
	return placed and not leaked

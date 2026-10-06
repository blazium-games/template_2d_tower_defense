extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_place_and_broke() -> void:
	var rules = Rules.new()
	assert_eq(rules.try_place(false), "off_lane", "off lane")
	assert_eq(rules.try_place(true), "placed", "paid")
	rules.purse = 1
	rules.placed = false
	assert_eq(rules.try_place(true), "broke", "cannot afford")

func test_leak() -> void:
	var rules = Rules.new()
	rules.march()
	assert_true(rules.leaked, "unplaced wave leaks")

func test_bend_gate() -> void:
	var rules = Rules.new()
	rules.march()
	assert_true(rules.leaked, "unplaced leak")
	assert_false(rules.may_bend(), "leaked")
	rules.reset_lane()
	assert_eq(rules.try_place(true), "placed", "paid")
	rules.march()
	assert_true(rules.may_bend(), "held")
	assert_true(load("res://scenes/bend.tscn") != null, "bend loads")

func test_sell() -> void:
	var rules = Rules.new()
	assert_eq(rules.sell(false), "rejected", "empty pad")
	assert_eq(rules.try_place(true), "placed", "paid")
	var before: int = rules.purse
	assert_eq(rules.sell(true), "sold", "refund")
	assert_eq(rules.purse, before + 2, "half cost")

extends Node

# Holds dictionaries that hold every skill visual (active and passive), based on move
# The dictionary both holds data about the skill with recurring formatting and
# all the visuals associated
# Skills must be ordered alphabetically

# ==========

# Deks and Initial setup

# Used at the start of a run to set the deafult cards in the CombatTracker.pl_skill_deck
func load_initial_deck(deck_name: String) -> void:
	assert(initial_decks.has(deck_name), "The deck_name doesn't exist in initial decks dictionary.")
	CombatTracker.pl_skill_deck.clear()
	CombatTracker.pl_skill_deck = initial_decks[deck_name]

var initial_decks: Dictionary = {
	# Debug deck for testing
	"Test Deck" : [
		"vaginal_penetration",
		"vaginal_penetration",
		"vaginal_penetration",
		"test_skill",
		"test_skill",
		"test_skill"
	]
}

# ==========

# MC to Monster

#	DICTIONARY FORMAT
#	"name": ,
#	"body_weakness": ,
#	"is_comment_forced: ,
#	"is_response_forced": ,
#	
#	"sprite_xxx": ,
#	"comment_xxx": ,
#	"response_xxx" : ,


var vaginal_penetration: Dictionary = {
	"name" : "Vaginal Penetration",
	"body_weakness" : [EnumDatabase.BodyWeaknesses.VAGINA],
	"description" : "Deal 3 OP to the enemy and 1 OP to yourself.",
	"is_comment_forced" : false,
	"is_response_forced" : false,
	
	"sprite_zero" : "Zero Vaginal Penetration",
	"response_zero" : [
		"Weakness hit.",
		"1... 2... 3... Getting hornier."
	]
}

func vaginal_penetration() -> void:
	var attack_op: int = 3
	var self_attack_op: int = 1
	simple_en_attack_op(attack_op, "vaginal_penetration")
	simple_pl_attack_op(self_attack_op)
	

var test_skill: Dictionary = {
	"name" : "Test Skill",
	"body_weakness" : [EnumDatabase.BodyWeaknesses.TIGHS],
	
	"sprite_zero" : "Zero Test Skill"
}

func test_skill() -> void:
	var attack_op: int = 1
	simple_en_attack_op(attack_op, "test_skill")


# ==========

# Monster to MC

# They don't have response

var cock_tickles: Dictionary = {
	"name": "Cock Tickles",
	"body_weakness": [EnumDatabase.BodyWeaknesses.NONE],
	"is_comment_forced" : true,
	
	"sprite_zero": "Sprite Zero Cock Tickles",
	"comment_zero" : [
		"Fingers executing tickles.",
		"Assessing cock consistency."
	],
}

func cock_tickles() -> void:
	CombatMethods.add_status(EnumDatabase.CombatStatus.SENSITIVE, CombatTracker.pl_status)

var tip_suck: Dictionary = {
	"name": "Tip Suck",
	"body_weakness": [EnumDatabase.BodyWeaknesses.NONE],
	"is_comment_forced" : false,
	
	"sprite_zero": "Sprite Zero Cock Tickles",
	"comment_zero" : [
		"Taste test in progress.",
		"Head cleaning."
	],
}

func tip_suck() -> void:
	var attack_op: int = 2
	simple_pl_attack_op(attack_op)


# ==========

# Utilities

# An attack that adds op to the enemy
func simple_en_attack_op(attack_op: int, skill: String) -> void:
	var skill_dict: Dictionary = get(skill)
	attack_op = CombatMethods.resistance_check(attack_op, skill_dict["body_weakness"], CombatTracker.en_monster_res)
	attack_op = CombatMethods.apply_status(CombatTracker.en_status, attack_op)
	CombatTracker.en_op = CombatMethods.incr_op_int(CombatTracker.en_op, attack_op)
	CombatMethods.tween_progressbar_value(get_node("/root/Combat").monsterop, get_node("/root/Combat").tween, CombatTracker.en_op)

# An attack that adds op to the player
func simple_pl_attack_op(self_attack_op: int) -> void:
	self_attack_op = CombatMethods.apply_status(CombatTracker.pl_status, self_attack_op)
	CombatTracker.pl_op = CombatMethods.incr_op_int(CombatTracker.pl_op, self_attack_op)
	CombatMethods.tween_progressbar_value(get_node("/root/Combat").playerop, get_node("/root/Combat").tween, CombatTracker.pl_op)

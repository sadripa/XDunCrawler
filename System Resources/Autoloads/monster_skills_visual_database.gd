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
#	"is_response_forced": ,
#	
#	"sprite_xxx": ,
#	"response_xxx" : ,


var vaginal_penetration: Dictionary = {
	"name" : "Vaginal Penetration",
	"body_weakness" : [EnumDatabase.BodyWeaknesses.VAGINA],
	"is_response_forced" : false,
	
	"sprite_zero" : "Zero Vaginal Penetration",
	"response_zero" : [
		"Weakness hit.",
		"1... 2... 3... Getting hornier."
	]
}

func vaginal_penetration() -> void:
	var attack_op: int = 5
	attack_op = CombatMethods.resistance_check(attack_op, vaginal_penetration["body_weakness"], CombatTracker.en_monster_res)
	CombatTracker.en_op = CombatMethods.incr_op_int(CombatTracker.en_op, attack_op)
	CombatMethods.tween_progressbar_value(get_node("/root/Combat").monsterop, get_node("/root/Combat").tween, CombatTracker.en_op)

var test_skill: Dictionary = {
	"name" : "Test Skill",
	"body_weakness" : [EnumDatabase.BodyWeaknesses.TIGHS],
	
	"sprite_zero" : "Zero Test Skill"
}

func test_skill() -> void:
	var attack_op: int = 5
	attack_op = CombatMethods.resistance_check(attack_op, test_skill["body_weakness"], CombatTracker.en_monster_res)
	CombatTracker.en_op = CombatMethods.incr_op_int(CombatTracker.en_op, attack_op)
	CombatMethods.tween_progressbar_value(get_node("/root/Combat").monsterop, get_node("/root/Combat").tween, CombatTracker.en_op)


# ==========

# Monster to MC

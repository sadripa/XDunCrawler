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

var vaginal_penetration: Dictionary = {
	"name" : "Vaginal Penetration",
	"body_weakness" : EnumDatabase.BodyWeaknesses.VAGINA,
	"sprite_zero" : "Zero Vaginal Penetration"
}

var test_skill: Dictionary = {
	"name" : "Test Skill",
	"body_weakness" : EnumDatabase.BodyWeaknesses.NONE,
	"sprite_zero" : "Zero Test Skill"
}


# ==========

# Monster to MC

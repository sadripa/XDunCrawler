extends Node

# Acts as a database for enums to be called from anywhere.

# ==========

# Monster Main

enum MonsterSpecies {
	NONE,
	ZERO
}

enum MonsterType {
	NONE,
	DOMINANT,
	SUBMISSIVE,
	VERASTILE
}

enum BodyWeaknesses {
	NONE,
	ANUS,
	ASS_CHEEKS,
	FEET,
	MOUTH,
	NIPPLES,
	TIGHS,
	TITS,
	TUMMY,
	VAGINA,
}

# =========

# Skill specific

enum SkillType {
	NONE,
	PENETRATION,
	STATUS,
	STIMULATION
}

# Used to highlight the result of skill use
enum SkillResult {
	NONE,
	RESIST,
	WEAK,
	CRIT_WEAK
}


# =========

# Combat specific

enum HornyStatus {
	NORMAL,
	WARM,
	HOT,
	CUM
}

# Statuses that can be applied by the field
enum CombatStatus {
	NONE,
	BROKEN,
	FRIGID,
	HORNY,
	SENSITIVE 
}

var combat_status_dict: Dictionary = {
	CombatStatus.SENSITIVE : [
		"Sensitive",
		"50% probability of doubling the OP inflicted."
	]
}

# ==========

# Scenery

enum SceneryStatus {
	NONE,
	COLD,
	HOT,
	ERO_SPORE
}

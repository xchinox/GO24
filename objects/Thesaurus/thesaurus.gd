class_name Thesaurus
extends Object

enum ActionType {

	ATTACK,
	DEFEND,
	SPELL,
	HEAL,
	SECRET,
	OTHER
}


var action_words: Dictionary = {
	ActionType.ATTACK: ["FIGHT", "ATTACK", "SMASH", "ASSAIL", "ASSAULT", "BASH", "MELEE", "CLEAVE", "SLASH", "RIPSOTE", "SWORD", "DAGGER", "CRUSH", "EXECUTE", "IMPALE"],

	ActionType.DEFEND: ["DEFEND", "ARMOR", "WALL", "BARRIER", "RESILIENCE", "FORTITUDE", "SHIELD", "BLOCK", "GUARD", "PROTECT", "MITIGATE", "AEGIS", "BASTION"],

	ActionType.SPELL: ["CAST", "MAGIC", "GRIMOIRE", "INCANTATION", "ARCANA", "MYSTICISM", "CONJURE", "EVOCATION", "CHANNEL", "MANA", "WAND"],

	ActionType.HEAL: ["MEDIC", "CURE", "CURATIVE", "HEALING", "CARE", "DEVOTION", "FAITH", "KINDNESS", "COMPASSION", "RESTORATION", "MERCY", "REGENERATE", "REJUVENATE", "RESTORE", "DIVINITY"],

	ActionType.SECRET: ["HIDDEN", "SECRET", "INCOGNITO", "CLOAKED", "ENIGMA", "CONCEALED", "OBSCURED", "ENCODED", "VEILED"]

}


func get_random_word_by_action(type: ActionType) -> String:
	var words: Array = action_words[type]
	return words[randi_range(0, words.size() - 1)]
	

func get_role_by_word(word: String) -> ActionType:
	if word in action_words[ActionType.ATTACK]:
		return ActionType.ATTACK
	if word in action_words[ActionType.DEFEND]:
		return ActionType.DEFEND
	if word in action_words[ActionType.SPELL]:
		return ActionType.SPELL
	if word in action_words[ActionType.HEAL]:
		return ActionType.HEAL
	if word in action_words[ActionType.SECRET]:
		return ActionType.SECRET
	return ActionType.OTHER

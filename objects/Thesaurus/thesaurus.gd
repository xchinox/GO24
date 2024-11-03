class_name Thesaurus
extends Object

enum ActionType {

	ATTACK,
	DEFEND,
	SPELL,
	HEAL,
	SECRET
}


var action_words: Dictionary = {
	ActionType.ATTACK: ["FIGHT", "ATTACK", "SMASH", "ASSAIL", "ASSAULT", "BASH", "MELEE"],

	ActionType.DEFEND: ["DEFEND",  "ARMOR", "WALL", "BARRIER"],

	ActionType.SPELL: ["CAST", "MAGIC", "GRIMOIRE", "INCANTATION"],

	ActionType.HEAL: ["MEDIC", "CURE", "CURATIVE", "HEALING", "CARE"],

	ActionType.SECRET: ["HIDDEN", "SECRET", "INCOGNITO", "CODE"]

}



func get_random_word_by_action(type: ActionType) -> String:
	var words: Array = action_words[type]
	return words[randi_range(0,words.size() -1 )]
	

class_name CharacterGrid
extends Object

enum Direction {UP, DOWN, LEFT, RIGHT, UP_RIGHT, DOWN_RIGHT, UP_LEFT, DOWN_LEFT}

#An active word
class ActiveWord:
	var word: String
	var action_type: Thesaurus.ActionType

	func _init(_word: String, _type: Thesaurus.ActionType) -> void:
		word = _word
		action_type = _type

var WIDTH := 13
var HEIGHT := 13
var abet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
var grid: Dictionary
var thes: Thesaurus = Thesaurus.new()
var active_words: Array[ActiveWord]
var protected_cells: Array[Vector2] = []
var valid_directions: Array[Direction] = []
var allowed_actions: Array[Thesaurus.ActionType] = [Thesaurus.ActionType.DEFEND, Thesaurus.ActionType.ATTACK, Thesaurus.ActionType.SPELL, Thesaurus.ActionType.HEAL, Thesaurus.ActionType.SECRET]
var directions: Dictionary = {
	Direction.UP: Vector2(0, -1),
	Direction.DOWN: Vector2(0, 1),
	Direction.LEFT: Vector2(-1, 0),
	Direction.RIGHT: Vector2(1, 0),
	Direction.UP_LEFT: Vector2(-1, -1),
	Direction.UP_RIGHT: Vector2(1, -1),
	Direction.DOWN_LEFT: Vector2(-1, 1),
	Direction.DOWN_RIGHT: Vector2(1, 1)
}


func initialize() -> void:
	populate_random()
	place_action_words()


func populate_random() -> void:
	for x in range(0, WIDTH):
		for y in range(0, HEIGHT):
			grid.get_or_add(Vector2(x, y), abet[randi_range(0, abet.length() - 1)])
		
func place_action_words() -> void:	
	for action_type in allowed_actions: 
		valid_directions.clear()
		var word: String = thes.get_random_word_by_action(action_type)
		var tries: int = 0
		while valid_directions.size() == 0 && tries <= 100:	
			tries += 1
			var random_pos: Vector2 = Vector2(randi_range(0, WIDTH), randi_range(0, HEIGHT))
			validate_word_placement(word, random_pos)
			if valid_directions.size() > 0:				
				replace_chars(word, random_pos, directions[valid_directions.pick_random()] as Vector2)		
				print("PLACED ", word, " FOR ACTION TYPE: ", action_type)		
				var active_word: ActiveWord = ActiveWord.new(word, action_type)
				active_words.append(active_word)
			else:
				print("ERROR COULD NOT PLACE: ", word)

func validate_word_placement(word: String, random_pos: Vector2) -> void:
	for direction: Direction in directions:
		if can_place(word, random_pos, directions[direction] as Vector2):
			valid_directions.append(direction)

func replace_chars(word: String, pos: Vector2, dir: Vector2 ) -> void:
	for i in range(0,word.length()):
		var current_pos := pos + (dir * i)
		grid[current_pos] = word[i]
		protected_cells.append(current_pos)

func can_place(word: String, pos: Vector2, dir: Vector2) -> bool:
	#If there is no blocker return true
	var blocker: bool = false
	
	for i in range(0, word.length()):
		var current_pos: Vector2 = pos + (dir * i)		
		if grid.has(current_pos) && !protected_cells.has(current_pos):
			continue
		else:					
			blocker = true
			break
	
	return !blocker

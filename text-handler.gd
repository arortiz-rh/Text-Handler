extends RichTextLabel
class_name TextHandler

enum Text_Movement_Options {
	## Displays the text one word at a time.
	By_Word,
	## Displays the text one character at a time.
	By_Character,
	## Displays the text instantly.
	Instant
}


## The file in which the dialogue will be read from.
@export var json_file : JSON = JSON.new()

## Choose how you want the text to be displayed.
@export var text_movement : Text_Movement_Options = Text_Movement_Options.Instant

## Sets how many characters are displayed per minute, only applicable when Text Movement is set to
## "By Character". All negative values will be treated as 0.
@export var char_per_minute : int = 100

## Sets how many words are displayed per minute, only applicable when Text Movement is set to
## "By Word". All negative values will be treated as 0.
@export var word_per_minute : int = 62

## Emitted after displaying final line of the inputted json.
signal end_of_dialogue

## Emitted when the current line of text has finished displaying.
signal end_of_line


var text_holder : Array
var current_speaker : String = ""
var current_line : String = ""
var dialogue_reached_end : bool = false
var line_reached_end : bool = false

func _ready() -> void:
	begin_dialogue()

func begin_dialogue() -> void:
	_process_json()
	next_line()

func next_line() -> void:
	var line_and_name : Dictionary = text_holder.pop_front()
	current_speaker = line_and_name.get("name")
	current_line = line_and_name.get("line")

	if text_holder.size() == 0:
		dialogue_reached_end = true
	else:
		dialogue_reached_end = false

	self.clear()

	match text_movement:
		Text_Movement_Options.By_Word:
			_word_by_word(current_line)
		Text_Movement_Options.By_Character:
			_character_by_character(current_line)
		Text_Movement_Options.Instant:
			_instant(current_line)

# HELPER FUNCTIONS
func _word_by_word(line : String) -> void:
	var word_array : PackedStringArray = line.split(" ", true)
	
	for i in word_array.size():
		self.append_text(word_array[i])
		if i != word_array.size():
			self.append_text(" ")
		await get_tree().create_timer(60 / word_per_minute).timeout

func _character_by_character(line : String) -> void:
	for i in line.length():
		self.append_text(line[i])
		await get_tree().create_timer(60 / char_per_minute).timeout

func _instant(line : String) -> void:
	self.append_text(line)

func _process_json() -> void:	
	if json_file.get_data() == null:
		assert(false, "No JSON inputted OR no data within JSON")
	
	text_holder = json_file.data

# SETTERS
func set_json(new_json : JSON) -> void:
	json_file = new_json

func set_text_movement(new_movement : Text_Movement_Options) -> void:
	text_movement = new_movement

# GETTERS
func get_speaker() -> String:
	return current_speaker

func get_char_speed() -> int:
	return char_per_minute

func get_word_speed() -> int:
	return word_per_minute

func get_json() -> JSON:
	return json_file

func get_end_of_dialogue() -> bool:
	return dialogue_reached_end

func get_end_of_line() -> bool:
	return line_reached_end

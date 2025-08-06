extends RichTextLabel
class_name TextHandler

enum Text_Movement_Options {
	## Displays the text one word at a time.
	By_Word,
	## Displays the text one character at a time.
	By_Character,
	## Displays the text instantly.
	All_at_Once
}


## The file in which the dialogue will be read from.
@export var json_file : JSON = JSON.new()

## Choose how you want the text to be displayed.
@export var text_movement : Text_Movement_Options

## Sets how many characters are displayed per minute, only applicable when Text Movement is set to
## "By Character". All negative values will be treated as 0.
@export var char_per_minute : int

## Sets how many words are displayed per minute, only applicable when Text Movement is set to
## "By Word". All negative values will be treated as 0.
@export var word_per_minute : int

## Emitted after displaying final line of the inputted json.
signal end_of_dialogue

## Emitted when the current line of text has finished displaying.
signal end_of_line

var text_holder : Array
var current_speaker : String = ""
var current_line : String = ""

func _ready() -> void:
	process_json()

func begin_dialogue() -> void:
	pass

func next_line() -> void:
	pass

# HELPER FUNCTIONS
func _word_by_word(line : String) -> void:
	pass

func _character_by_character(line : String) -> void:
	pass

func _all_at_once(line : String) -> void:
	pass

func process_json() -> void:	
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

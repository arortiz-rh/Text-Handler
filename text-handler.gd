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
@export var json_file : JSON

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

func begin_dialogue():
	pass

# This text handler doesn't manage the dialogue, it only concerns itself with displaying. There must
# be an external signal that triggers this next function to show the next piece of dialogue.
func next():
	pass

# HELPER FUNCTIONS
func _word_by_word(line : String):
	pass

func _character_by_character(line : String):
	pass

func _all_at_once(line : String):
	pass


# SETTERS
func set_json(file_path : String):
	pass

func set_text_movement(new_movement : Text_Movement_Options):
	pass

# GETTERS
func get_speaker():
	pass

func get_char_speed():
	pass

func get_word_speed():
	pass

func get_json():
	pass

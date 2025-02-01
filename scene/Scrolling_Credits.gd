extends RichTextLabel

var Credits = "\t\t    Game Lead: Gavin Liles\t\tAssistant Lead: Bijay Khanal\n
 Team AI    \tTeam Movement    \tTeam GUI    \tTeam Level Design  \tTeam Art\n
AI Lead: John Wesley Thompson   "

func _ready() -> void:
	scroll_text(Credits)
	
func scroll_text(input_text:String) -> void:
	visible_characters = 0
	text = input_text
	
	for i in get_parsed_text():
		visible_characters += 1
		await get_tree().create_timer(.01).timeout
		
		

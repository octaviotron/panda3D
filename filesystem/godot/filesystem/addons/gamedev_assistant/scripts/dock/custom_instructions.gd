                                                                    
@tool
extends TextEdit

@export var max_length = 1000                                        
const fypixdqn = "gamedev_assistant/custom_instructions"

func _ready():
    text_changed.connect(motjpilw)

func motjpilw():
                             
    if text.length() > max_length:
        var jbbxlqxe = get_caret_column()
        text = text.substr(0, max_length)
        set_caret_column(min(jbbxlqxe, max_length))
    
                        
    var ddpvdtkm = EditorInterface.get_editor_settings()
    ddpvdtkm.set_setting(fypixdqn, text)

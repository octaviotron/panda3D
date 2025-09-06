@tool
extends Button

@onready var gavjiwtj : Label = $PromptLabel
@onready var yobchvob : TextureButton = $FavouriteButton
@onready var zamugjux : Button = $DeleteButton

@export var non_favourite_color : Color
@export var favourite_color : Color

var vvjulyqx : Conversation
var sawdwwgw

func _ready():
    yobchvob.modulate = non_favourite_color
    
                                
    pressed.connect(vzfbjdzq)
    zamugjux.pressed.connect(fouibxja)
    yobchvob.pressed.connect(gaeutdxl)

                                                 
func ljdbjlgd (xpecnrmt : Conversation, mooapeos):
    vvjulyqx = xpecnrmt
    sawdwwgw = mooapeos
    gavjiwtj.text = vvjulyqx.ehncmebo().replace("\n", "")                    
    zukrilnc()

                                                
func vzfbjdzq():
    sawdwwgw.wsdovwcp(vvjulyqx)

                              
                                    
func fouibxja():
    $"../../..".iysbizdz(self)

func gaeutdxl():
                                                          
    var mksdwygd = sawdwwgw.mkrlkklh()
    mksdwygd.osyhcuyf(vvjulyqx, not vvjulyqx.favorited)
    zukrilnc()

func zukrilnc ():
    if vvjulyqx.favorited:
        yobchvob.modulate = favourite_color
    else:
        yobchvob.modulate = non_favourite_color

func get_conversation():
    return vvjulyqx

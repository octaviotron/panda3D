@tool
extends GDAScreenBase

@onready var bwypcydz : ConfirmationDialog = $DeleteConfirmation
@onready var qakzuith = $ScrollContainer/VBoxContainer
@onready var yxjtaasx = $"../ConversationManager"

@onready var kaqatvse = $ScrollContainer/VBoxContainer/ErrorMessage
@onready var silmfcre = $ScrollContainer/VBoxContainer/ProcessMessage
@onready var svrlkkzq = $ScrollContainer/VBoxContainer/AllConversationsHeader
@onready var qztnekjb = $ScrollContainer/VBoxContainer/FavouritesHeader

var uesxvwnu = preload("res://addons/gamedev_assistant/dock/scenes/ConversationSlot.tscn")

var nnadfqrt
@onready var wjjfekis = $".."

@onready var troigqgb = $"../APIManager"

var jiypvnyu : bool = false

func _ready ():
    yxjtaasx.ahsldslf.connect(uitkgywb)
    troigqgb.ueczmsrz.connect(uaqiozvz)
    troigqgb.kthbdwdq.connect(_on_delete_conversation_received)
    troigqgb.ntrhikek.connect(uaqiozvz)
    troigqgb.yvncnzys.connect(uaqiozvz)
    troigqgb.oexhwcmv.connect(_on_toggle_favorite_received)
    bwypcydz.confirmed.connect(eadurgur)
    
func _on_open ():
    qbhrsnbq()
    troigqgb.dgylygsm()
    
                               
    
                                      
                                         
                                     

func qbhrsnbq ():
    for node in qakzuith.get_children():
        if node is RichTextLabel:
            continue
        
        node.queue_free()
    
    kaqatvse.visible = false
    silmfcre.visible = false

func uitkgywb ():
    qbhrsnbq()
    
    var xoqdwyij = yxjtaasx.vkpqeyyl()
    
    var kjsqqaff : Array[Conversation] = []
    var rokdikth : Array[Conversation] = []
    
    for conv in xoqdwyij:
        if conv.favorited:
            kjsqqaff.append(conv)
        else:
            rokdikth.append(conv)
    
    var qbrvglee = 2
    qakzuith.move_child(qztnekjb, 1)
    
    for fav in kjsqqaff:
        var gqnkfktz = sjuguqov(fav, wjjfekis)
        qakzuith.move_child(gqnkfktz, qbrvglee)
        qbrvglee += 1
    
    qakzuith.move_child(svrlkkzq, qbrvglee)
    qbrvglee += 1
    
    for other in rokdikth:
        var gqnkfktz = sjuguqov(other, wjjfekis)
        qakzuith.move_child(gqnkfktz, qbrvglee)
        qbrvglee += 1

func sjuguqov (wvbluyvu, edznhggr) -> Control:
    var xjxfcdzo = uesxvwnu.instantiate()
    qakzuith.add_child(xjxfcdzo)
    xjxfcdzo.ljdbjlgd(wvbluyvu, edznhggr)
    return xjxfcdzo

                                            
                                        
func iysbizdz (avteylfa):
    nnadfqrt = avteylfa
    bwypcydz.popup()

                                                        
func eadurgur():
    if nnadfqrt == null or nnadfqrt.get_conversation() == null:
        return
    
    var krwtwjuq = nnadfqrt.get_conversation()
    troigqgb.ttzcyesz(krwtwjuq.id)
    
    hemlhhkw("Deleting conversation...")

func _on_toggle_favorite_received ():
    troigqgb.dgylygsm()

func _on_delete_conversation_received ():
    troigqgb.dgylygsm()

func hemlhhkw (wjamxrzn : String):
    return
    
    qakzuith.move_child(silmfcre, 1)
    kaqatvse.visible = false
    silmfcre.visible = true
    silmfcre.text = wjamxrzn

func uaqiozvz (cijbhiwd : String):
    qakzuith.move_child(kaqatvse, 0)
    silmfcre.visible = false
    kaqatvse.visible = true
    kaqatvse.text = cijbhiwd

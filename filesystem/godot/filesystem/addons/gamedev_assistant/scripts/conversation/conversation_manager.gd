@tool
extends Node

                                        
                             
                               

signal irotvbge (conversation : Conversation)

                                                                    
signal ahsldslf
signal mndvjuty

var mzblckia : Array[Conversation]
var frxejias : Conversation

@onready var bzofbvsp = $"../APIManager"
@onready var ohztmfcj = $".."
@onready var cqcthlie = $"../Screen_Conversations"

func _ready ():
    bzofbvsp.ivmxjkuz.connect(wawkwtfa)
    bzofbvsp.seqbhvhs.connect(_on_send_message_received)
    
    bzofbvsp.xbbrbqeo.connect(fjmpjcsi)
    bzofbvsp.hlaoyzmh.connect(jjwmyfgt)

func bmnygzgh () -> Conversation:
    yluummxx()                                            

    var zpebtbpe = Conversation.new()
    zpebtbpe.id = -1                                       
    mzblckia.append(zpebtbpe)
    frxejias = zpebtbpe
    return zpebtbpe

func yluummxx ():
    if frxejias != null:
        if frxejias.id == -1:                                    
            mzblckia.erase(frxejias)
    
    frxejias = null

func pfkduwvl (mjfbzbjt : Conversation):
    frxejias = mjfbzbjt
    mndvjuty.emit()

                                                                    
                                                                              
func fjmpjcsi (gaicxuor):
    mzblckia.clear()
    
    for conv_data in gaicxuor:
        var iuxgqbst = Conversation.new()
        iuxgqbst.id = int(conv_data["id"])
        iuxgqbst.title = conv_data["title"]
        iuxgqbst.favorited = conv_data["isFavorite"]
        mzblckia.append(iuxgqbst)
    
    ahsldslf.emit()

                                   
func wawkwtfa(awwextin: String):
    if frxejias == null:
                                           
        bmnygzgh()
    
                                                     
                                                    
                           
       
    frxejias.gvqxykmu(awwextin)

func _on_send_message_received(ebgamubc: String, vgdfibok: int):
    print("Received assistant message: ", {
        "conversation_id": vgdfibok,
        "current_conv_id": frxejias.id if frxejias else "none",
        "content": ebgamubc
    })
    if frxejias:
        if frxejias.id == -1:
                                                                    
            frxejias.id = vgdfibok
        frxejias.sojvygsy(ebgamubc)

                                                                                      
                                                                     
func hyhxecii (hfzvzdsh : int):
    bzofbvsp.get_conversation(hfzvzdsh)

                                                            
                                                 
func jjwmyfgt (rnhtmnkm):
    var fuwaeaqh : Conversation
    var juhbyrfq = rnhtmnkm["id"]
    juhbyrfq = int(juhbyrfq)
    
                                                
    for c in mzblckia:
        if c.id == juhbyrfq:
            fuwaeaqh = c
            break
    
                                              
    if fuwaeaqh == null:
        fuwaeaqh = Conversation.new()
        fuwaeaqh.id = juhbyrfq
        fuwaeaqh.title = rnhtmnkm["title"]
        mzblckia.append(fuwaeaqh)
    
    fuwaeaqh.messages.clear()
    
                                                    
    for message in rnhtmnkm["messages"]:
        if message["role"] == "user":
            fuwaeaqh.gvqxykmu(message["content"])
        elif message["role"] == "assistant":
            fuwaeaqh.sojvygsy(message["content"])
    
    fuwaeaqh.has_been_fetched = true
    pfkduwvl(fuwaeaqh)

func osyhcuyf (ukezevlz : Conversation, jfehyivh : bool):
    bzofbvsp.pprjnnxc(ukezevlz.id)
    
    if jfehyivh:
        cqcthlie.hemlhhkw("Adding favorite...")
    else:
        cqcthlie.hemlhhkw("Removing favorite...")

func vkpqeyyl():
    return mzblckia
    
func jcbkvlxa():
    return frxejias
    
func rjiqioqs(mlyarhjk: int):
    frxejias.id = mlyarhjk

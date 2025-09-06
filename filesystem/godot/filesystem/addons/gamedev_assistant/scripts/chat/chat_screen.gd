                                                       
@tool
extends GDAScreenBase

signal luvmqokm

var kwvoeqvu : RichTextLabel = null

@onready var deghtorj : TextEdit = $Footer/PromptInput
@onready var hlfvwgvd : Button = $Footer/SendPromptButton
@onready var egikbcjz : Control = $Footer
@onready var bicdlmur : Control = $Body

@onready var bgjivzxv = $"../APIManager"
@onready var ytwakxwd = $"../ActionManager"

var ohuhkyqk = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_UserPrompt.tscn")
var ingjfufo = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_ServerResponse.tscn")
var iaxupsfo = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_ErrorMessage.tscn")
const zzwvzxkd = preload("res://addons/gamedev_assistant/scripts/chat/markdown_to_bbcode.gd")
var jyiiinjh = preload("res://addons/gamedev_assistant/scripts/chat/message_tagger.gd").new()
var ecmxblpj = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_CodeBlockResponse.tscn")
var gknxoncr = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_CodeBlockUser.tscn")
var hpyoabws = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_Spacing.tscn")

var ksqlsjdt := false
var zsqborjn: String = ""

                                                   
var zafzlcnv : String = ""
var niejklji : String = ""
var hqehhcbb  : String = ""
var auglzfxf : String = ""
var fksmezwn  : String = ""

var amkxofat : int = -1

@onready var ahrpogan = $Body/MessagesContainer
@onready var sxcdegtd = $Body/MessagesContainer/ThinkingLabel
@onready var sziltmgy = $Bottom/AddContext
@onready var ndawzzma : CheckButton = $Bottom/ReasoningToggle
@onready var phxnqmmy = $Body/MessagesContainer/RatingContainer
@onready var oyyfdqip = $Bottom/Mode

@onready var fhqrfscw = preload("res://addons/gamedev_assistant/dock/icons/stop.png")  
@onready var nzpebdoj = preload("res://addons/gamedev_assistant/dock/icons/arrowUp.png")  

var lsaviayy = [
    "",
    " @OpenScripts ",
    " @Output ",
    " @Docs ",
    " @GitDiff ",
    " @ProjectSettings"
]

@onready var zwppuuxb = $"../ConversationManager"

var waiting_nonthinking = "Thinking ⚡"
var waiting_thinking = "Reasoning ⌛ This could take multiple minutes"

var notice_actions_nonthinking = "Generating one-click actions ⌛ To skip, press ■"
var notice_actions_thinking = "Generating one-click actions ⌛ To skip, press ■"


func _ready ():
    bgjivzxv.seqbhvhs.connect(zdvajiex)
    bgjivzxv.rganywqo.connect(gtyzqvbj)
    
    zwppuuxb.mndvjuty.connect(dzwwagcd)
    deghtorj.diletico.connect(bajhqumb)
    
                       
    bgjivzxv.qdrkqqif.connect(cregrmhx)
    bgjivzxv.rndrgjvr.connect(hmhtxtih)
    bgjivzxv.svofymbg.connect(jgdbxhwh)
    bgjivzxv.ibfuqrbf.connect(uhljzjjd)

    sziltmgy.item_selected.connect(hippifgp)    
    hlfvwgvd.pressed.connect(foqvynvm)   
    
    phxnqmmy.get_node("UpButton").pressed.connect(wtvhyzpc)
    phxnqmmy.get_node("DownButton").pressed.connect(kciagrep)
    phxnqmmy.visible = false 

func _on_open ():
    deghtorj.text = ""
    sxcdegtd.visible = false
    phxnqmmy.visible = false 
    vypkrksn(false)
    ewzvrtmd()
    sziltmgy.selected = 0
    zsqborjn = ''
    

                                                            
func xwwtqzpo ():
    ksqlsjdt = true
    vypkrksn(true)
    amkxofat = -1
    phxnqmmy.visible = false
    jyiiinjh.kcivvsot()
    
                    
    niejklji = ""
    hqehhcbb  = ""
    auglzfxf = ""
    fksmezwn  = ""
    zafzlcnv = ""

func cregrmhx(pgomopzn: String, atxvcwhj: int, irlhymrj: int) -> void:
    if kwvoeqvu == null:
        kwvoeqvu = ingjfufo.instantiate()
        kwvoeqvu.bbcode_enabled = true
        ahrpogan.add_child(kwvoeqvu)
        var wsksyncp = hpyoabws.instantiate()
        ahrpogan.add_child(wsksyncp)
        sxcdegtd.visible = false
        zsqborjn = pgomopzn
        
        if irlhymrj != -1:
            amkxofat = irlhymrj
    else:
        zsqborjn += pgomopzn
        
                                                  
    kwvoeqvu.text = zzwvzxkd.jfhrldes(zsqborjn)
    
                                                                     
    if not kwvoeqvu.meta_clicked.is_connected(lxofwgsp):  
        kwvoeqvu.meta_clicked.connect(lxofwgsp)  
    
    if atxvcwhj > 0:
        zwppuuxb.rjiqioqs(atxvcwhj)

func jgdbxhwh(gcxkmvsm: int, yopuuiui: int) -> void:
    if kwvoeqvu:
        kwvoeqvu.visible = false

                                                                
    ipjpdgmj(zsqborjn, ingjfufo, ahrpogan, ecmxblpj)
    
                              
    ahrpogan.move_child(sxcdegtd, ahrpogan.get_child_count() - 1)
    sxcdegtd.visible = true
    sxcdegtd.text = notice_actions_nonthinking

func hmhtxtih(kjqifpjp: int, zdfwhomq: int) -> void:
                                         
    if kwvoeqvu:
        kwvoeqvu.queue_free()
        kwvoeqvu = null
        
    sxcdegtd.visible = false
    
                                                    
    ahrpogan.move_child(phxnqmmy, ahrpogan.get_child_count() - 1)
    phxnqmmy.visible = zdfwhomq > 0
    
                          
    var qlbinytx = ytwakxwd.aaultoff(zsqborjn, zdfwhomq)
    ytwakxwd.cpqazivl(qlbinytx, ahrpogan)

    zsqborjn = ""
    vypkrksn(true)
    sxcdegtd.visible = false
    hlfvwgvd.icon = nzpebdoj

func uhljzjjd(slobyjaf: String):
    udynxxpo(slobyjaf)
    vypkrksn(true)
    sxcdegtd.visible = false
    kwvoeqvu = null
    hlfvwgvd.icon = nzpebdoj

func foqvynvm():  
    if bgjivzxv.vfvjigkr():  
                                         
        bgjivzxv.uisimxca.emit()  
        
                                             
        if kwvoeqvu:
            kwvoeqvu.queue_free()
            kwvoeqvu = null
        
        vypkrksn(true)  
        hlfvwgvd.icon = nzpebdoj  
        
        if not sxcdegtd.visible:
                                                                        
            ipjpdgmj(zsqborjn, ingjfufo, ahrpogan, ecmxblpj)
        
        sxcdegtd.visible = false  
        
                                                   
        ahrpogan.move_child(phxnqmmy, ahrpogan.get_child_count() - 1)
        phxnqmmy.visible = amkxofat > 0

    else:  
                                             
        kwbvazcz()  

func kwbvazcz():
                                                        
    ytwakxwd.cvcajeex()
    
    phxnqmmy.visible = false
    
    amkxofat = -1
    
    if len(deghtorj.text) < 1:
        return
    
    var qtiphspm = deghtorj.text

                                                        
    var gzemohml := false
    if ksqlsjdt:
        var bhedtxre = Engine.get_singleton("EditorInterface") if Engine.is_editor_hint() else null
        auglzfxf = jyiiinjh.nldceowi("", bhedtxre)
        fksmezwn  = jyiiinjh.enipyray("", bhedtxre)
        zafzlcnv = "[gds_context]Current project context:[/gds_context]\n" \
            + auglzfxf + "\n" + fksmezwn
        gzemohml = true
    else:
        gzemohml = xmuhhnor()

    if gzemohml and zafzlcnv != "":
        qtiphspm += zafzlcnv
                          
        niejklji = auglzfxf
        hqehhcbb  = fksmezwn

    ksqlsjdt = false

    if Engine.is_editor_hint():
        var bhedtxre = Engine.get_singleton("EditorInterface")
        qtiphspm = jyiiinjh.vbznwneg(qtiphspm, bhedtxre)
        
    var zsldvlye = ndawzzma.button_pressed
    var zknwhbfg : int = oyyfdqip.selected
    var qmesfxcr : String
    
    if zknwhbfg == 0:
        qmesfxcr = "CHAT"
    else:
        qmesfxcr = "AGENT"        
    
    bgjivzxv.omwltbdh(qtiphspm, zsldvlye, qmesfxcr)
    stvgksqn(deghtorj.text)                               
    vypkrksn(false)
    deghtorj.text = ""
    
    if zsldvlye:
        sxcdegtd.text = waiting_thinking
    else:
        sxcdegtd.text = waiting_nonthinking
        
    sxcdegtd.visible = true
    ahrpogan.move_child(sxcdegtd, ahrpogan.get_child_count() - 1)
    
                                               
    luvmqokm.emit()
    
func vypkrksn (gbertyes : bool):
    if gbertyes:  
        hlfvwgvd.icon = nzpebdoj  
    else:  
        hlfvwgvd.icon = fhqrfscw  

func zdvajiex (gwdmjaca : String, yctnfxst : int):
    kepipjeu(gwdmjaca)
    vypkrksn(true)
    sxcdegtd.visible = false

func gtyzqvbj (caskdpyt : String):
    udynxxpo(caskdpyt)
    vypkrksn(true)
    sxcdegtd.visible = false

func stvgksqn(uocbcegk: String):
                                                                               
    ipjpdgmj(uocbcegk, ohuhkyqk, ahrpogan, gknxoncr)
    
    var dyycfwki = hpyoabws.instantiate()
    ahrpogan.add_child(dyycfwki)


func kepipjeu(ioebjrip: String):
                                                                                
    ipjpdgmj(ioebjrip, ingjfufo, ahrpogan, ecmxblpj)
    
    var lnlekefn = hpyoabws.instantiate()
    ahrpogan.add_child(lnlekefn)

func udynxxpo (zsfggatk : String):
    var syqzozab = iaxupsfo.instantiate()
    ahrpogan.add_child(syqzozab)
    syqzozab.text = zsfggatk

func ewzvrtmd ():
    for node in ahrpogan.get_children():
        if node == sxcdegtd or node == phxnqmmy:
            continue
        node.queue_free()
    ahrpogan.custom_minimum_size = Vector2.ZERO
    
    luvmqokm.emit()
    
                  
    jyiiinjh.kcivvsot()
    
                            
    niejklji = ""
    hqehhcbb  = ""
    auglzfxf = ""
    fksmezwn  = ""
    zafzlcnv = ""

func dzwwagcd ():
    var wvypwnui = zwppuuxb.jcbkvlxa()
    ewzvrtmd()
    
    for msg in wvypwnui.messages:
        if msg.role == "user":
            stvgksqn(msg.content)
        elif msg.role == "assistant":
            kepipjeu(msg.content)
    
    vypkrksn(true)

func hippifgp(qjijclbz: int):
    if qjijclbz >= 0 and qjijclbz < lsaviayy.size():
        deghtorj.text += " " + lsaviayy[qjijclbz]
        sziltmgy.select(0)

func lxofwgsp(wchhyyfi):
    OS.shell_open(str(wchhyyfi))

                                                
func ennzutuz(ltmnnsya: String) -> String:
    
    var kdvdoldo = RegEx.new()
                                 
    kdvdoldo.compile("\\[gds_context\\](.|\\n)*?\\[/gds_context\\]")
    ltmnnsya = kdvdoldo.sub(ltmnnsya, "", true)
    
                                       
    kdvdoldo.compile("<internal_tool_use>(.|\\n)*?</internal_tool_use>")
    return kdvdoldo.sub(ltmnnsya, "", true)
    
                                                
func cbnyrolm(dgqwhhwh: String) -> String:
        
    var pegztawj = RegEx.new()
    pegztawj.compile("\\[gds_actions\\](.|\\n)*?\\[/gds_actions\\]")
    return pegztawj.sub(dgqwhhwh, "", true)

func foqptwlj(gjodfjus: String):
    gjodfjus = gjodfjus.replace(notice_actions_nonthinking, '').replace(notice_actions_thinking, '').strip_edges()
    return gjodfjus
    
func ipjpdgmj(iviwldpp: String, wbkhxmfa: PackedScene, azfwpfyi: Node, fjcbkapn: PackedScene) -> void:
    
    iviwldpp = iviwldpp.strip_edges()
    iviwldpp = ennzutuz(iviwldpp)
    
                       
    var kfwgzgwh = zzwvzxkd.xsxddjvu(iviwldpp)

    for block in kfwgzgwh:
        if block["type"] == "text":
            var gjpkufdh = wbkhxmfa.instantiate()
            gjpkufdh.bbcode_enabled = true
            azfwpfyi.add_child(gjpkufdh)
            
            var ktgdnton = block["content"]
            
                                                      
            ktgdnton = zzwvzxkd.noclknhm(ktgdnton)
            ktgdnton = zzwvzxkd.okicodcp(ktgdnton)
            ktgdnton = ktgdnton.strip_edges()
            
            gjpkufdh.text = ktgdnton

                                 
            if not gjpkufdh.meta_clicked.is_connected(lxofwgsp):
                gjpkufdh.meta_clicked.connect(lxofwgsp)

        elif block["type"] == "code":
            var kgmsjuic = fjcbkapn.instantiate()
            azfwpfyi.add_child(kgmsjuic)
            kgmsjuic.text = block["content"]

                           
func xmuhhnor() -> bool:
    var nsqjnkvd = Engine.get_singleton("EditorInterface") if Engine.is_editor_hint() else null
    auglzfxf = jyiiinjh.nldceowi("", nsqjnkvd)
    fksmezwn  = jyiiinjh.enipyray("", nsqjnkvd)

    var dfuwbqxd = auglzfxf != niejklji
    var pnwkyguy  = fksmezwn  != hqehhcbb

    var fxfotumy = []
    if dfuwbqxd:
        fxfotumy.append(auglzfxf)
    if pnwkyguy:
        fxfotumy.append(fksmezwn)

    zafzlcnv = ""
    if fxfotumy.size() > 0:
        zafzlcnv = "[gds_context]Current project context:[/gds_context]\n" + "\n".join(fxfotumy)

    return dfuwbqxd or pnwkyguy

                               
func bajhqumb() -> void:
    var txdurptc = not bgjivzxv.vfvjigkr()
    if txdurptc:
        kwbvazcz()
        
func wtvhyzpc():
    if amkxofat > 0:
        bgjivzxv.hfurysvq(amkxofat, 5)
        phxnqmmy.visible = false                     

func kciagrep():
    if amkxofat > 0:
        bgjivzxv.hfurysvq(amkxofat, 1)
        phxnqmmy.visible = false

                                  
@tool
extends GDAScreenBase

var vvgkrkps : Label
var iomgfiqi : LineEdit
var rltdpltz : CheckButton
var mkttwfza : Button
var rymwrhqz : RichTextLabel
var hoysighe : RichTextLabel
var rvgwvhuj : RichTextLabel
var fxjpbure : Button
var bdwivtva : LineEdit
var rphziuek : Button
var fuwottob : Button
var ihcsseqh : String

const urhothxh : String = "gamedev_assistant/hide_token"
const zqhdwktn : String = "gamedev_assistant/validated"
const zpxxaxoi : String = "gamedev_assistant/custom_instructions"

@onready var detesdfg = $".."
@onready var oyusezhn = $"../APIManager"
@onready var rqvisdwd = $"VBoxContainer/CustomInput"

var qeppgwvz : bool

func _ready ():
    oyusezhn.vongmkpc.connect(_on_validate_token_received)
    oyusezhn.pykspeua.connect(_on_check_updates_received)
    oyusezhn.jwumvijw.connect(ehvkmhcl)
    
    qadhygjn()
    
                                             
    rltdpltz.toggled.connect(pjtfbpwf)
    mkttwfza.pressed.connect(hmhplaxw)
    rphziuek.pressed.connect(rapkpdzx)
    fuwottob.pressed.connect(xpswnczp)
    iomgfiqi.text_changed.connect(oxcutvku)
    
    rymwrhqz.visible = false
    hoysighe.visible = false
    rvgwvhuj.visible = false
    
    var czjnplwr = EditorInterface.get_editor_settings()       
    
    czjnplwr.set_setting("gamedev_assistant/version_identifier", "74JmCC82h")
    
    qeppgwvz = czjnplwr.has_setting("gamedev_assistant/development_mode") and czjnplwr.get_setting('gamedev_assistant/development_mode') == true    
    if not qeppgwvz:
        czjnplwr.set_setting("gamedev_assistant/endpoint", "https://app.gamedevassistant.com")
        ihcsseqh = "gamedev_assistant/token"
    else:
        czjnplwr.set_setting("gamedev_assistant/endpoint", "http://localhost:3000")
        ihcsseqh = "gamedev_assistant/token_dev"
        print("Development mode")
        
    oyusezhn.qdpyhjqd()
    
                                                                         
                                                  
func qadhygjn ():
    vvgkrkps = $VBoxContainer/EnterTokenPrompt
    iomgfiqi = $VBoxContainer/Token_Input
    rltdpltz = $VBoxContainer/HideToken
    mkttwfza = $VBoxContainer/ValidateButton
    rymwrhqz = $VBoxContainer/TokenValidationSuccess
    hoysighe = $VBoxContainer/TokenValidationError
    rvgwvhuj = $VBoxContainer/TokenValidationProgress
    rphziuek = $VBoxContainer/AccountButton
    fuwottob = $VBoxContainer/UpdatesButton

func pjtfbpwf (vvkxoaoa):
    iomgfiqi.secret = vvkxoaoa
    
    var yyebtkdn = EditorInterface.get_editor_settings()
    yyebtkdn.set_setting(urhothxh, rltdpltz.button_pressed)

func oxcutvku (rytuxdjh):
    if len(iomgfiqi.text) == 0:
        vvgkrkps.visible = true
    else:
        vvgkrkps.visible = false
    
    detesdfg.lcftmpbu(false)
    
    rymwrhqz.visible = false
    hoysighe.visible = false
    rvgwvhuj.visible = false
    
    var mogiielq = EditorInterface.get_editor_settings()
    mogiielq.set_setting(ihcsseqh, iomgfiqi.text)

func hmhplaxw ():
    mkttwfza.disabled = true
    rymwrhqz.visible = false
    hoysighe.visible = false
    rvgwvhuj.visible = true
    oyusezhn.ttgmshwc()

                                                        
func _on_validate_token_received (qnevujmb : bool, hvccdukp : String):
    rvgwvhuj.visible = false
    mkttwfza.disabled = false
    
    if qnevujmb:
        rymwrhqz.visible = true
        rymwrhqz.text = "Token has been validated!"
        
        var tfbrsdzh = EditorInterface.get_editor_settings()
        tfbrsdzh.set_setting(zqhdwktn, true)
        
        detesdfg.lcftmpbu(true)
    else:
        hoysighe.visible = true
        hoysighe.text = hvccdukp

                                                  
                                                  
func _on_open ():
    qadhygjn()
    var zmcqqpcg = EditorInterface.get_editor_settings()
    
    if zmcqqpcg.has_setting(ihcsseqh):
        iomgfiqi.text = zmcqqpcg.get_setting(ihcsseqh)
    
    if zmcqqpcg.has_setting(urhothxh):
        rltdpltz.button_pressed = zmcqqpcg.get_setting(urhothxh)
    
    iomgfiqi.secret = rltdpltz.button_pressed
    
    if len(iomgfiqi.text) == 0:
        vvgkrkps.visible = true
    else:
        vvgkrkps.visible = false
        
    if zmcqqpcg.has_setting(zpxxaxoi):
        rqvisdwd.text = zmcqqpcg.get_setting(zpxxaxoi)

func rapkpdzx():
    OS.shell_open("https://app.gamedevassistant.com/profile")
    
func xpswnczp():
    rymwrhqz.visible = false
    hoysighe.visible = false
    rvgwvhuj.visible = true
    
    oyusezhn.trmanpkv()

func _on_check_updates_received(desjatsv: bool, uwjwlorq: String):
    rvgwvhuj.visible = false
    
    if desjatsv:
        rymwrhqz.visible = true
        rymwrhqz.text = "An update is available! Latest version: " + uwjwlorq + ". Click 'Manage Account' to download it."
    else:
        rymwrhqz.visible = true
        rymwrhqz.text = "You are already in the latest version"

func ehvkmhcl(akkckdoy: String):
    rvgwvhuj.visible = false
    hoysighe.visible = true
    hoysighe.text = akkckdoy
    

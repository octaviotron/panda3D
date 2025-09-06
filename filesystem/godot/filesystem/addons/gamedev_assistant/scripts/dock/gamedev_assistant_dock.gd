                                         
@tool
extends Control

@onready var mtedgsse = $Screen_Conversations
@onready var xqabhove = $Screen_Chat
@onready var tnquarkn = $Screen_Settings

@onready var ysnlaazd = $Header/HBoxContainer/ConversationsButton
@onready var xfgfcgde = $Header/ChatButton
@onready var sohlruyz = $Header/HBoxContainer/SettingsButton
@onready var wbwkrzni = $Header/ScreenText

@onready var nnbaiynf = $ConversationManager
@onready var rjscqtch = $APIManager

                                          
var nttnhrix : bool = false

                                                    
var wisqokrn : bool = false

func _ready():
    lcftmpbu(false)
    
                                       
    rjscqtch.pykspeua.connect(oivkapcm)
    rjscqtch.jwumvijw.connect(oivkapcm)
    
                                   
    xfgfcgde.pressed.connect(axxfeatc)
    sohlruyz.pressed.connect(wcdmhovj)
    ysnlaazd.pressed.connect(ctgdxljq)
    
    var fdcpaokb = EditorInterface.get_editor_settings()
    
                                        
    var nrysmqjf = fdcpaokb.has_setting("gamedev_assistant/development_mode") and fdcpaokb.get_setting('gamedev_assistant/development_mode') == true    
    if nrysmqjf:
        kzbdwarc()
    
    if fdcpaokb.has_setting("gamedev_assistant/validated"):
        if fdcpaokb.get_setting("gamedev_assistant/validated") == true:
            axxfeatc()
            lcftmpbu(true)
                        
                                                             
            rjscqtch.trmanpkv(true)
            return
                                          
    elif !fdcpaokb.has_setting("gamedev_assistant/onboarding_shown"):
        kzbdwarc()
        fdcpaokb.set_setting("gamedev_assistant/onboarding_shown", true)
        
    vekpczqw(tnquarkn, "Settings")

func vekpczqw (gsqlgwnk, zfhgndwj):
    mtedgsse.visible = false
    xqabhove.visible = false
    tnquarkn.visible = false
    
                                                 
    gsqlgwnk.visible = true
    gsqlgwnk._on_open()
    
    wbwkrzni.text = zfhgndwj
    
    wisqokrn = gsqlgwnk == xqabhove
    
                       
    rjscqtch.uisimxca.emit()
    
                                                                
                                                           
                                       

func ctgdxljq():
    vekpczqw(mtedgsse, "Conversations")

func axxfeatc():
    nnbaiynf.yluummxx()
    vekpczqw(xqabhove, "New Conversation")
    xqabhove.xwwtqzpo()
    rjscqtch.uisimxca.emit()

func wcdmhovj():
    if tnquarkn.visible:
        return
    
    vekpczqw(tnquarkn, "Settings")

func wsdovwcp (wdxggclv : Conversation):
    nnbaiynf.hyhxecii(wdxggclv.id)
    vekpczqw(xqabhove, "Chat")

func lcftmpbu (ijogdphe : bool):
    nttnhrix = ijogdphe
    xfgfcgde.disabled = !ijogdphe
    ysnlaazd.disabled = !ijogdphe
    
                                                               
func oivkapcm(dlgdkzsm, param2 = ""):
                                                                                       
                                                            
    
    var pyuilgcs = AcceptDialog.new()
    pyuilgcs.get_ok_button().text = "Close"
    
                                                                                 
    if dlgdkzsm is bool:
                                                             
        var ogodjmdo = dlgdkzsm
        var mhnypvje = param2
        
                                                   
        if ogodjmdo:
            pyuilgcs.title = "GameDev Assistant Update"
            pyuilgcs.dialog_text = "An update is available! Latest version: " + mhnypvje + ". Go to https://app.gamedevassistant.com to download it."
            add_child(pyuilgcs)
            pyuilgcs.popup_centered()
    else:
                                                           
        var rpmfzgix = dlgdkzsm
        pyuilgcs.title = "GameDev Assistant Update"
        pyuilgcs.dialog_text = rpmfzgix
        add_child(pyuilgcs)
        pyuilgcs.popup_centered()

func kzbdwarc():
    var tlnfizbw = AcceptDialog.new()
    tlnfizbw.title = "Welcome Aboard! 🚀"
    tlnfizbw.dialog_text = "Welcome to GameDev Assistant by Zenva!\n\n🌟 To get started:\n1. Find the Assistant tab (next to Inspector, Node, etc, use arrows < > to find it)\n2. Enter your token in Settings\n3. Start a chat with the + button\n4. Switch between Chat and Agent mode to find your perfect workflow\n\n\nHappy gamedev! 🎮"
    tlnfizbw.ok_button_text = "Close"
    tlnfizbw.dialog_hide_on_ok = true
    add_child(tlnfizbw)
    tlnfizbw.popup_centered()

func mkrlkklh():
    return nnbaiynf

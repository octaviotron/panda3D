                                                        
@tool                                                                                         
extends TextEdit                                                                              
                                                                                                
signal diletico    

const doojsdnb = 50000                                                                    
                                                                                                
var bkunglva : bool = false                                                              
var xtnpyfvi : Control                                                                          
                         
                                                                                    
func _ready():                                                                                
                                                                                              
    xtnpyfvi = get_parent()       
    
                       
    tooltip_text = "Type your message here (Enter to send, Shift+Enter for new line)\nTo include scripts you need to either paste the code here, use @OpenScripts,\n or select the code in the editor + right click for contextual menu \"Add to Chat\"\nThe file tree and open scene nodes are automatically included"
                                                                                                
                                                                                              
    connect("focus_entered", Callable(self, "roisbapa"))                
    connect("text_changed", Callable(self, "eifwvcbp")) 
    connect("focus_exited", Callable(self, "lpjqzchv"))            
    
    var sydsnnjy = get_parent().get_parent()                                                    
    if sydsnnjy.has_signal("luvmqokm"):  
        sydsnnjy.connect("luvmqokm", Callable(self, "agcjvpjy"))  
                
                                                                                                
func _input(bxqswkfs):
    if has_focus():
        if bxqswkfs is InputEventKey and bxqswkfs.is_pressed():
            if bxqswkfs.keycode == KEY_ENTER:
                if bxqswkfs.shift_pressed:
                    insert_text_at_caret("\n")
                                                                
                    ltjfalqh(1)
                    get_viewport().set_input_as_handled()
                else:                                                                         
                                                                             
                    var makncict = get_parent().get_node("SendPromptButton")  
                    if makncict and makncict.disabled == false:  
                        diletico.emit()                                                       
                        get_viewport().set_input_as_handled()
                        agcjvpjy()    

func ltjfalqh(pdobuxxq: int = 0):
    var egdvcrjz = get_theme_font("font")
    var yvjwziil = get_theme_font_size("font_size")
    var zznqcafa = egdvcrjz.get_char_size('W'.unicode_at(0), yvjwziil).x * 0.6
    var hlsulwkz = int(size.x / zznqcafa)
    var npagbaqr = egdvcrjz.get_height(yvjwziil) + 10
    var wjdjffqd = npagbaqr * 10        
    var ceizaqku = npagbaqr*2
    var cvnzonlf = -ceizaqku*2
    
    var wwjjhcyc = 0
    for i in get_line_count():
        var lrrhwmos = get_line(i)
        var nflvnawx = lrrhwmos.length()
        var rfxzxmat = ceili(float(nflvnawx) / float(hlsulwkz))
        wwjjhcyc += max(rfxzxmat, 1)                         
        
                                             
    wwjjhcyc += pdobuxxq
    
    var gwmxhqiv = wwjjhcyc * npagbaqr + ceizaqku
    gwmxhqiv = clamp(gwmxhqiv, ceizaqku, wjdjffqd)
    xtnpyfvi.offset_top = -gwmxhqiv


func unqcsdql():
    ltjfalqh()                                                                        
                                                                                                
func roisbapa():                                                        
    unqcsdql()                                                                     
                                                                                                
func eifwvcbp():                                                         
    unqcsdql()
    
                                                                                     
    if text.length() > doojsdnb:                                               
        text = text.substr(0, doojsdnb)                                        
        set_caret_column(doojsdnb)                                                                                                        
                                                                                                
func agcjvpjy():                                                                    
    unqcsdql()

func lpjqzchv(): 
    if text.length() == 0:                                                        
        agcjvpjy()

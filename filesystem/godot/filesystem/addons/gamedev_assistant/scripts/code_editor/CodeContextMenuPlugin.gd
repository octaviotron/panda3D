extends EditorContextMenuPlugin

var rwzolwys: Control

func _init(lwxwywnw: Control):                                                
    rwzolwys = lwxwywnw

                                                                              
func zgaodglb(qzkboyku: PackedStringArray):
    add_context_menu_item("Add to Chat",pqxwmslr)
    add_context_menu_item("Explain Code",jqqtkroz)

func jqqtkroz(fkhwsbey: Node):
    if not (fkhwsbey is CodeEdit):
        return
    if fkhwsbey.has_selection():
        var qwquipjt = fkhwsbey.get_selected_text()
        if qwquipjt:         
                                                      
            var xpqnoyyl = Engine.get_singleton("EditorInterface")
            var jwzrsyrf = xpqnoyyl.get_script_editor().get_current_script()
            if jwzrsyrf:
                qwquipjt = "Explain this code from %s:\n\n%s" % [jwzrsyrf.resource_path, qwquipjt]
            
                                                                                    
            if rwzolwys:  
                if not rwzolwys.is_open_chat:
                    print("Please open the chat to use this command")
                    return
                                                                    
                var bzzwfoih : TextEdit = rwzolwys.get_node("Screen_Chat/Footer/PromptInput")         
                if bzzwfoih:                                               
                    bzzwfoih.insert_text_at_caret("\n" +qwquipjt)          
                else:                                                               
                    print("PromptInput node not found in the dock.")                
            else:                                                                   
                print("Dock reference is null.")          

func pqxwmslr(gcbusweg: Node):
    if not (gcbusweg is CodeEdit):
        return
    if gcbusweg.has_selection():
        var frnmczjn = gcbusweg.get_selected_text()
        if frnmczjn:
                                                      
            var tvojzfyu = Engine.get_singleton("EditorInterface")
            var oxyjvpch = tvojzfyu.get_script_editor().get_current_script()
            if oxyjvpch:
                frnmczjn = "Snippet from %s:\n%s" % [oxyjvpch.resource_path, frnmczjn]
            
                                                                                    
            if rwzolwys:          
                if not rwzolwys.is_open_chat:
                    print("Please open the chat to use this command")
                    return
                                                                      
                var yaaaiirz : TextEdit = rwzolwys.get_node("Screen_Chat/Footer/PromptInput")         
                if yaaaiirz:                                               
                    yaaaiirz.insert_text_at_caret("\n" +frnmczjn)             
                else:                                                               
                    print("PromptInput node not found in the dock.")                
            else:                                                                   
                print("Dock reference is null.")          

            
            
            

                                                                      
@tool
extends Node

const uyxqufpe = preload("action_parser_utils.gd")

static func execute(xvdjrscb: String, kmcefoqk: int, sqoqmqqa: Button, nhacsrnq: Node) -> Variant:
                                      
    var zqqaouit = FileAccess.open(xvdjrscb, FileAccess.READ)
    if not zqqaouit:
        var bjnpcxoz = FileAccess.get_open_error()
        var glxrqvmd = "Failed to load script: " + xvdjrscb + " (Error: " + error_string(bjnpcxoz) + ")"
        push_error(glxrqvmd)
        return {"success": false, "error_message": glxrqvmd}
    
                                
    var phtskyuc = zqqaouit.get_as_text()
    zqqaouit.close()
        
                                                                                        
    nhacsrnq.detuqvgg(xvdjrscb, kmcefoqk, phtskyuc, sqoqmqqa)
    
                                                                                       
    return null

static func parse_line(nehxhrpk: String, wgxqwbaa: String) -> Dictionary:
    if nehxhrpk.begins_with("edit_script("):
        var enjpfczu = uyxqufpe.oneoigrd(nehxhrpk)
        if not enjpfczu.is_empty():
            return {
                "type": "edit_script",
                "path": enjpfczu.get("path", ""),
                "message_id": enjpfczu.get("message_id", -1)
            }
    return {}

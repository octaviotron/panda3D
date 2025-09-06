                                                                 
@tool
extends Node

const dgwjhvlv = preload("action_parser_utils.gd")
const nfuihlkc = preload("edit_node_action.gd")

static func execute(vcxzmark: String, hafvydzi: String, oogviifj: String, ptfvtglb: String, suxvfdxh: Dictionary = {}) -> Dictionary:
    var paeyjbgh = EditorPlugin.new().get_editor_interface()
    var zlvapemk = paeyjbgh.get_open_scenes()
    
                                                             
    for scene in zlvapemk:
        if scene == oogviifj:
            print("Adding to open scene: ", scene)
            paeyjbgh.reload_scene_from_path(oogviifj)
            return hhweypzc(vcxzmark, hafvydzi, paeyjbgh.get_edited_scene_root(), ptfvtglb, suxvfdxh)

                                                                                                     
    print("Adding to closed scene: ", oogviifj)
    return xkobsyci(vcxzmark, hafvydzi, oogviifj, ptfvtglb, suxvfdxh)

static func hhweypzc(nvqibcxp: String, gwfiomgt: String, xbhgswea: Node, csyibfcb: String, cbnsvjet: Dictionary = {}) -> Dictionary:
    if !ClassDB.class_exists(gwfiomgt):
        var jqdufoyc = "Node type '%s' does not exist." % gwfiomgt
        push_error(jqdufoyc)
        return {"success": false, "error_message": jqdufoyc}
    var blleuoen = ClassDB.instantiate(gwfiomgt)
    blleuoen.name = nvqibcxp
    
                                                         
    var wmowciiz = xbhgswea if (csyibfcb.is_empty() or csyibfcb == xbhgswea.name) else xbhgswea.find_child(csyibfcb, true, true)
    if not wmowciiz:
        var jqdufoyc = "Parent node '%s' not found in scene." % csyibfcb
        push_error(jqdufoyc)
        return {"success": false, "error_message": jqdufoyc}
    
    wmowciiz.add_child(blleuoen)
    blleuoen.set_owner(xbhgswea)
    
                                
    if not cbnsvjet.is_empty():
        var bqelkmnw = nfuihlkc.vcrnkowu(blleuoen, cbnsvjet, xbhgswea)
        if not bqelkmnw.success:
            return bqelkmnw                                       
    
                                                  
    if EditorInterface.save_scene() == OK:
        return {"success": true, "error_message": ""}
    else:
        var jqdufoyc = "Failed to save the scene."
        push_error(jqdufoyc)
        return {"success": false, "error_message": jqdufoyc}


static func xkobsyci(cqiuprys: String, amyjbmfb: String, oalnjvdv: String, cfqwthxn: String, fdhtnkjc: Dictionary = {}) -> Dictionary:
    var uqgrdxyn = load(oalnjvdv)
    if !uqgrdxyn is PackedScene:
        var peqmpxpc = "Failed to load scene '%s' as PackedScene." % oalnjvdv
        push_error(peqmpxpc)
        return {"success": false, "error_message": peqmpxpc}
    
    var xsmrqaac = uqgrdxyn.instantiate()
    if !ClassDB.class_exists(amyjbmfb):
        var peqmpxpc = "Node type '%s' does not exist." % amyjbmfb
        push_error(peqmpxpc)
        return {"success": false, "error_message": peqmpxpc}
    var urvisdto = ClassDB.instantiate(amyjbmfb)
    urvisdto.name = cqiuprys
    
                                                         
    var pysyxago = xsmrqaac if (cfqwthxn.is_empty() or cfqwthxn == xsmrqaac.name) else xsmrqaac.find_child(cfqwthxn, true, true)
    if not pysyxago:
        var peqmpxpc = "Parent node '%s' not found in uqgrdxyn." % cfqwthxn
        push_error(peqmpxpc)
        return {"success": false, "error_message": peqmpxpc}
    
    pysyxago.add_child(urvisdto)
    urvisdto.set_owner(xsmrqaac)
    
                                
    if not fdhtnkjc.is_empty():
        var gtqgrkfr = nfuihlkc.vcrnkowu(urvisdto, fdhtnkjc, xsmrqaac)
        if not gtqgrkfr.success:
            return gtqgrkfr                                       
    
                                                          
    uqgrdxyn.pack(xsmrqaac)

    if ResourceSaver.save(uqgrdxyn, oalnjvdv) == OK:
        return {"success": true, "error_message": ""}
    else:
        var peqmpxpc = "Failed to save the packed scene."
        push_error(peqmpxpc)
        return {"success": false, "error_message": peqmpxpc}

static func parse_line(qvuahyfo: String, zmoaksil: String) -> Dictionary:
    if qvuahyfo.begins_with("create_node("):
                                                                              
        var axngihqa = dgwjhvlv.gntnayem(qvuahyfo)
        if axngihqa.size() < 3:
            return {}
        
                                                                 
        var ldhiqiar = {}
        var qnjvnszi = qvuahyfo.find("{")
        var farzswjh = qvuahyfo.rfind("}")
        
        if qnjvnszi != -1 and farzswjh != -1:
            var ukqiidvt = qvuahyfo.substr(qnjvnszi, farzswjh - qnjvnszi + 1)
            ldhiqiar = dgwjhvlv.viedyrep(ukqiidvt)
        
        return {
            "type": "create_node",
            "name": axngihqa[0],
            "node_type": axngihqa[1],
            "scene_path": axngihqa[2],
            "parent_path": axngihqa[3] if axngihqa.size() > 3 else "",
            "modifications": ldhiqiar
        }
    return {}

                                                                 
@tool
extends Node

const cywyejbz = preload("action_parser_utils.gd")
const tbfrglvn = preload("edit_node_action.gd")

static func execute(lmklymkc: String, dpvipyka: String, rjtcjthz: String, hagncxzf: String, aiqdzfes: Dictionary) -> Dictionary:
    var lkmkktcb = EditorPlugin.new().get_editor_interface()
    var jaumaqhz = lkmkktcb.get_open_scenes()
    
    var zbhzsjuy = load(dpvipyka)
    if not zbhzsjuy is PackedScene:
        var pqtsytqh = "Invalid or non-existent scene file: " + dpvipyka
        push_error(pqtsytqh)
        return {"success": false, "error_message": pqtsytqh}
    
    if rjtcjthz in jaumaqhz:
        return xbtzrmkh(lmklymkc, zbhzsjuy, rjtcjthz, hagncxzf, aiqdzfes)
    else:
        return gfrrncme(lmklymkc, zbhzsjuy, rjtcjthz, hagncxzf, aiqdzfes)

static func xbtzrmkh(voxqcdvt: String, guldvmff: PackedScene, aexgymjf: String, oagecebs: String, opqmiefp: Dictionary) -> Dictionary:
    var vintklgy = EditorPlugin.new().get_editor_interface()
    vintklgy.reload_scene_from_path(aexgymjf)
    var mtbtbjld = vintklgy.get_edited_scene_root()
    
    var cfbfegsx = mtbtbjld if (oagecebs.is_empty() or oagecebs == mtbtbjld.name) else mtbtbjld.find_child(oagecebs, true, true)
    if not cfbfegsx:
        var kdapqgye = "Parent node '%s' not found in scene '%s'." % [oagecebs, aexgymjf]
        push_error(kdapqgye)
        return {"success": false, "error_message": kdapqgye}
    
    var cneksssi = guldvmff.instantiate()
    cneksssi.name = voxqcdvt
    cfbfegsx.add_child(cneksssi)
    cneksssi.set_owner(mtbtbjld)
    
    if not opqmiefp.is_empty():
        var bxdaoexd = tbfrglvn.vcrnkowu(cneksssi, opqmiefp, mtbtbjld)
        if not bxdaoexd.success:
            return bxdaoexd                                       
    
    if EditorPlugin.new().get_editor_interface().save_scene() == OK:
        return {"success": true, "error_message": ""}
    else:
        var kdapqgye = "Failed to save scene '%s'." % aexgymjf
        push_error(kdapqgye)
        return {"success": false, "error_message": kdapqgye}


static func gfrrncme(hclqgyjo: String, tqkatcwo: PackedScene, xiezbaek: String, honyqosq: String, hkuprgdf: Dictionary) -> Dictionary:
    var ovlzddpn = load(xiezbaek)
    if not ovlzddpn is PackedScene:
        var ftjhuwdw = "Invalid or non-existent target scene: " + xiezbaek
        push_error(ftjhuwdw)
        return {"success": false, "error_message": ftjhuwdw}
    
    var empcyvkn = ovlzddpn.instantiate()
    var eeutxdtb = empcyvkn if (honyqosq.is_empty() or honyqosq == empcyvkn.name) else empcyvkn.find_child(honyqosq, true, true)
    if not eeutxdtb:
        var ftjhuwdw = "Parent node '%s' not found in scene '%s'." % [honyqosq, xiezbaek]
        push_error(ftjhuwdw)
        return {"success": false, "error_message": ftjhuwdw}
    
    var nlxaaehg = tqkatcwo.instantiate()
    nlxaaehg.name = hclqgyjo
    eeutxdtb.add_child(nlxaaehg)
    nlxaaehg.set_owner(empcyvkn)
    
    if not hkuprgdf.is_empty():
        var konktysu = tbfrglvn.vcrnkowu(nlxaaehg, hkuprgdf, empcyvkn)
        if not konktysu.success:
            return konktysu                                       
    
    ovlzddpn.pack(empcyvkn)
    if ResourceSaver.save(ovlzddpn, xiezbaek) == OK:
        return {"success": true, "error_message": ""}
    else:
        var ftjhuwdw = "Failed to save packed scene '%s'." % xiezbaek
        push_error(ftjhuwdw)
        return {"success": false, "error_message": ftjhuwdw}

static func parse_line(mnzdfbxc: String, pycajtug: String) -> Dictionary:
    if mnzdfbxc.begins_with("add_existing_scene("):
        var xzdwdhyj = mnzdfbxc.replace("add_existing_scene(", "").strip_edges()
        if xzdwdhyj.ends_with(")"):
            xzdwdhyj = xzdwdhyj.substr(0, xzdwdhyj.length() - 1).strip_edges()
        
        var irlzcquk = []
        var cvtbeknz = 0
                                             
        for _i in range(4):
            var yufggflb = xzdwdhyj.find('"',cvtbeknz)
            if yufggflb == -1: return {}
            var rsqzebem = xzdwdhyj.find('"', yufggflb + 1)
            if rsqzebem == -1: return {}
            irlzcquk.append(xzdwdhyj.substr(yufggflb + 1, rsqzebem - yufggflb - 1))
            cvtbeknz = rsqzebem + 1
        
                                        
        var ubmhqxcj = {}
        var bhywytlj = xzdwdhyj.substr(cvtbeknz).strip_edges()
        if bhywytlj.begins_with("{"):
            ubmhqxcj = cywyejbz.viedyrep(bhywytlj)
        
        return {
            "type": "add_existing_scene",
            "node_name": irlzcquk[0],
            "existing_scene_path": irlzcquk[1],
            "target_scene_path": irlzcquk[2],
            "parent_path": irlzcquk[3],
            "modifications": ubmhqxcj
        }
    return {}

                                                                     
@tool
extends Node

const qgyiptkx = preload("action_parser_utils.gd")

static func execute(canepgfr: String, nhxpznzf: String, gomyrlnv: String, qotffdlg: Dictionary) -> Dictionary:
    var jxrcmfjm = EditorPlugin.new().get_editor_interface()
    var aojxhlos = jxrcmfjm.get_open_scenes()

                                   
    for scene in aojxhlos:
        if scene == nhxpznzf:
                                                                   
            jxrcmfjm.reload_scene_from_path(nhxpznzf)
            return _add_to_open_scene(canepgfr, jxrcmfjm.get_edited_scene_root(), gomyrlnv, qotffdlg)

                                           
                                                             
    return _add_to_closed_scene(canepgfr, nhxpznzf, gomyrlnv, qotffdlg)


static func _add_to_open_scene(wtrshpla: String, pdmomzqh: Node, lugaqjpr: String, eepgmkzb: Dictionary) -> Dictionary:
    var hdzsvbbq = opeioapp(wtrshpla, pdmomzqh)
    if not hdzsvbbq:
        return {"success": false, "error_message": "Node '%s' not found." % wtrshpla, "node_type": ""}

    var yerffpkm = ivnkvnbd(lugaqjpr, eepgmkzb)
    if not yerffpkm:
                                       
        return {"success": false, "error_message": "Could not create or configure resource '%s'." % lugaqjpr, "node_type": hdzsvbbq.get_class()}

    if not eepgmkzb.has("assign_to_property"):
        var scmbcpng = "No 'assign_to_property' field in eepgmkzb dictionary."
        push_error(scmbcpng)
        return {"success": false, "error_message": scmbcpng, "node_type": hdzsvbbq.get_class()}

    var dkazndjr = String(eepgmkzb["assign_to_property"])
    if not xaqdyyox(hdzsvbbq, dkazndjr, yerffpkm):
                                       
        var scmbcpng = "Failed to assign new resource to property '%s'." % dkazndjr
        return {"success": false, "error_message": scmbcpng, "node_type": hdzsvbbq.get_class()}

    if EditorInterface.save_scene() == OK:
        return {"success": true, "error_message": "", "node_type": hdzsvbbq.get_class()}
    else:
        var scmbcpng = "Failed to save the scene."
        push_error(scmbcpng)
        return {"success": false, "error_message": scmbcpng, "node_type": hdzsvbbq.get_class()}

static func _add_to_closed_scene(elkklenm: String, zideapwt: String, ladldslt: String, nfsbopse: Dictionary) -> Dictionary:
    var cxbuueso = load(zideapwt)
    if !(cxbuueso is PackedScene):
        var wqypkdat = "Failed to load scene '%s' as PackedScene." % zideapwt
        push_error(wqypkdat)
        return {"success": false, "error_message": wqypkdat, "node_type": ""}

    var aegbntyp = cxbuueso.instantiate()
    if not aegbntyp:
        var wqypkdat = "Could not instantiate scene '%s'." % zideapwt
        push_error(wqypkdat)
        return {"success": false, "error_message": wqypkdat, "node_type": ""}

    var girrlekj = opeioapp(elkklenm, aegbntyp)
    if not girrlekj:
        return {"success": false, "error_message": "Node '%s' not found." % elkklenm, "node_type": ""}

    var afyjqenn = ivnkvnbd(ladldslt, nfsbopse)
    if not afyjqenn:
        return {"success": false, "error_message": "Could not create or configure resource '%s'." % ladldslt, "node_type": girrlekj.get_class()}

    if not nfsbopse.has("assign_to_property"):
        var wqypkdat = "No 'assign_to_property' field in nfsbopse dictionary."
        push_error(wqypkdat)
        return {"success": false, "error_message": wqypkdat, "node_type": girrlekj.get_class()}

    var pggjskvb = String(nfsbopse["assign_to_property"])
    if not xaqdyyox(girrlekj, pggjskvb, afyjqenn):
        var wqypkdat = "Failed to assign new resource to property '%s'." % pggjskvb
        return {"success": false, "error_message": wqypkdat, "node_type": girrlekj.get_class()}

    cxbuueso.pack(aegbntyp)
    if ResourceSaver.save(cxbuueso, zideapwt) == OK:
        return {"success": true, "error_message": "", "node_type": girrlekj.get_class()}
    else:
        var wqypkdat = "Failed to save the packed scene."
        push_error(wqypkdat)
        return {"success": false, "error_message": wqypkdat, "node_type": girrlekj.get_class()}

                                                                             
         
                                                                             
static func opeioapp(faybmfgy: String, bqpuqlcb: Node) -> Node:
    var kxvmzkij = bqpuqlcb.find_child(faybmfgy, true, true)
    if not kxvmzkij and faybmfgy == bqpuqlcb.name:
        kxvmzkij = bqpuqlcb

    if not kxvmzkij:
        push_error("Node '%s' not found in the scene." % faybmfgy)
        return null

    return kxvmzkij


static func ivnkvnbd(eepwmzfm: String, hkasghda: Dictionary) -> Resource:
    if not ClassDB.class_exists(eepwmzfm):
        push_error("Resource type '%s' does not exist." % eepwmzfm)
        return null

    var sidgbndq = ClassDB.instantiate(eepwmzfm)
    if not sidgbndq:
        push_error("Could not instantiate resource of type '%s'." % eepwmzfm)
        return null

                                                                  
    for property_name in hkasghda.keys():
        if property_name == "assign_to_property":
            continue

        var kiculbqd = hkasghda[property_name]
        var xobkhalb = _parse_value(kiculbqd)
        if xobkhalb == null and kiculbqd != null:
            push_error("Failed to parse value '%s' for property '%s'." % [str(kiculbqd), property_name])
            return null

        if not plywputh(sidgbndq, property_name, xobkhalb):
            return null

    return sidgbndq


static func _parse_value(ugujlede) -> Variant:
                                                             
    if ugujlede is String:
        var crzpckdr = ugujlede.strip_edges()
                                                 
        if crzpckdr.begins_with("(") and crzpckdr.ends_with(")"):
            var cuppiefo = crzpckdr.substr(1, crzpckdr.length() - 2)
            var jbosnqtj = cuppiefo.split(",", false)
            if jbosnqtj.size() == 2:
                return Vector2(float(jbosnqtj[0].strip_edges()), float(jbosnqtj[1].strip_edges()))
            elif jbosnqtj.size() == 3:
                return Vector3(float(jbosnqtj[0].strip_edges()), float(jbosnqtj[1].strip_edges()), float(jbosnqtj[2].strip_edges()))
            elif jbosnqtj.size() == 4:
                return Vector4(float(jbosnqtj[0].strip_edges()), float(jbosnqtj[1].strip_edges()), float(jbosnqtj[2].strip_edges()), float(jbosnqtj[3].strip_edges()))
        if crzpckdr.to_lower() == "true":
            return true
        if crzpckdr.to_lower() == "false":
            return false
        if crzpckdr.is_valid_float():
            return float(crzpckdr)
                                       
        return crzpckdr

                                                                  
    return ugujlede


static func xaqdyyox(shbdkjaw: Node, adstnzxf: String, ehhuecrf: Variant) -> bool:
    var qlzdysih = shbdkjaw.get(adstnzxf)
    var bqrhofnz = true
                                                                                          
                                                                                                        
                                         
      
                                                                                                            
                                                                 

                    
    shbdkjaw.set(adstnzxf, ehhuecrf)
                                               
    if shbdkjaw.get(adstnzxf) != ehhuecrf:
        push_error("Failed to set property '%s' on node '%s' value: %s." % [adstnzxf, shbdkjaw.name, ehhuecrf])
        bqrhofnz = false
                          
    return bqrhofnz


static func plywputh(bpyulovo: Resource, ukcpxupl: String, gcssaujd: Variant) -> bool:
                                                    
    var rtwwwwwx = bpyulovo.get_property_list()
    var qrxfrsdw = null

                                           
    for prop_info in rtwwwwwx:
        if prop_info.name == ukcpxupl:
            qrxfrsdw = prop_info.type
            break

                                              
    if qrxfrsdw == null:
        push_error("Property '%s' doesn't exist on resource '%s'." % [ukcpxupl, bpyulovo.get_class()])
        return true                                                              

                                                                                 
                                         
    if qrxfrsdw == TYPE_COLOR:
        match typeof(gcssaujd):
            TYPE_VECTOR2:
                                                    
                gcssaujd = Color(gcssaujd.x, gcssaujd.y, 0, 1.0)
            TYPE_VECTOR3:
                                                        
                gcssaujd = Color(gcssaujd.x, gcssaujd.y, gcssaujd.z, 1.0)
            TYPE_VECTOR4:
                                                        
                gcssaujd = Color(gcssaujd.x, gcssaujd.y, gcssaujd.z, gcssaujd.w)
            TYPE_ARRAY:
                                                                                         
                if gcssaujd.size() == 3:
                    gcssaujd = Color(gcssaujd[0], gcssaujd[1], gcssaujd[2], 1.0)
                elif gcssaujd.size() == 4:
                    gcssaujd = Color(gcssaujd[0], gcssaujd[1], gcssaujd[2], gcssaujd[3])
                                                                       
                                           
            
                                                                    
    elif qrxfrsdw == TYPE_VECTOR3 and typeof(gcssaujd):
        gcssaujd = Vector3(gcssaujd.x, gcssaujd.y, 0)

                    
    bpyulovo.set(ukcpxupl, gcssaujd)

                                                   
    var pcqclvxh = bpyulovo.get(ukcpxupl)
    
    var unwdzbce : bool
    
    if typeof(gcssaujd) in [TYPE_VECTOR2, TYPE_VECTOR3, TYPE_VECTOR4]:
        if typeof(pcqclvxh) == typeof(gcssaujd):
            unwdzbce = pcqclvxh.is_equal_approx(gcssaujd)
        else:
            push_error("Wrong data type for property %s" % [ukcpxupl])
            unwdzbce = false
    elif typeof(gcssaujd) == TYPE_FLOAT and typeof(pcqclvxh) == TYPE_FLOAT:
                             
                         
        unwdzbce = is_equal_approx(gcssaujd, pcqclvxh)
    else:
        unwdzbce = pcqclvxh == gcssaujd

                                                                              
    if typeof(pcqclvxh) == typeof(gcssaujd) and not unwdzbce:
        push_error("Failed to set resource property '%s' on resource '%s' value: %s " % [ukcpxupl, bpyulovo.get_class(), gcssaujd])
        return false

    return true



                                                                             
            
                                                       
                                                               
                                                                             
                           
static func parse_line(phitmaqf: String, kdlnbzeq: String) -> Dictionary:
    if phitmaqf.begins_with("add_subresource("):
        var soupvgvr = phitmaqf.replace("add_subresource(", "")
        if soupvgvr.ends_with(")"):
            soupvgvr = soupvgvr.substr(0, soupvgvr.length() - 1)
        soupvgvr = soupvgvr.strip_edges()

        var zrnoglbi = []
        var sxgxmsyo = 0
        while true:
            var fqdtzzge = soupvgvr.find('"',sxgxmsyo)
            if fqdtzzge == -1:
                break
            var jdwzwouu = soupvgvr.find('"', fqdtzzge + 1)
            if jdwzwouu == -1:
                break
            zrnoglbi.append(soupvgvr.substr(fqdtzzge + 1, jdwzwouu - (fqdtzzge + 1)))
            sxgxmsyo = jdwzwouu + 1

        var ivahbgoz = soupvgvr.find("{")
        var yypueudd = soupvgvr.rfind("}")
        if ivahbgoz == -1 or yypueudd == -1:
            return {}

        var dvdorcxx = soupvgvr.substr(ivahbgoz, yypueudd - ivahbgoz + 1)
        var jhlmabjj = qgyiptkx.viedyrep(dvdorcxx)

                                                                               
                                                                                
                                  
        for key in jhlmabjj.keys():
            var xeblhamz = jhlmabjj[key]
            if xeblhamz is String:
                var aogpgoid = xeblhamz.strip_edges()
                if aogpgoid.begins_with("\"") and aogpgoid.ends_with("\"") and aogpgoid.length() > 1:
                    aogpgoid = aogpgoid.substr(1, aogpgoid.length() - 2)
                jhlmabjj[key] = aogpgoid
                                                                               

        if zrnoglbi.size() < 3:
            return {}

        return {
            "type": "add_subresource",
            "node_name": zrnoglbi[0],
            "scene_path": zrnoglbi[1],
            "subresource_type": zrnoglbi[2],
            "properties": jhlmabjj
        }

    return {}

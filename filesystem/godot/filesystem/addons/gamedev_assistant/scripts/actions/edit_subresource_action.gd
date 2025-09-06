                                                                      
@tool
extends Node

const ibulhqcn = preload("action_parser_utils.gd")
                                                                            
                                                   
const vwovbotc = preload("add_subresource_action.gd")

static func execute(phmtmhzu: String, wxcvmglc: String, itortisc: String, tsswonev: Dictionary) -> Dictionary:
    var olmgrluz = EditorPlugin.new().get_editor_interface()
    var sjzquizm = olmgrluz.get_open_scenes()

                                   
    for scene in sjzquizm:
        if scene == wxcvmglc:
                                                                    
            olmgrluz.reload_scene_from_path(wxcvmglc)
            return _edit_in_open_scene(phmtmhzu, olmgrluz.get_edited_scene_root(), itortisc, tsswonev)

                                           
                                                              
    return _edit_in_closed_scene(phmtmhzu, wxcvmglc, itortisc, tsswonev)


static func _edit_in_open_scene(macbajjf: String, wtipgowq: Node, bexjwrrm: String, obbilwil: Dictionary) -> Dictionary:
    var ewpihigd = vwovbotc.opeioapp(macbajjf, wtipgowq)               
    if not ewpihigd:
                                              
        return {"success": false, "error_message": "Node '%s' not found." % macbajjf, "node_type": "", "subresource_type": ""}

    var ebfaryzf = ewpihigd.get(bexjwrrm)
    if not (ebfaryzf is Resource):
        var zabklvvp = "Property '%s' on node '%s' is not a Resource or doesn't exist." % [bexjwrrm, macbajjf]
        push_error(zabklvvp)
        return {"success": false, "error_message": zabklvvp, "node_type": ewpihigd.get_class(), "subresource_type": ""}

    var ovowdxbb = pvmxgwey(ebfaryzf, obbilwil)
    if not ovowdxbb.success:
        return {"success": false, "error_message": ovowdxbb.error_message, "node_type": ewpihigd.get_class(), "subresource_type": ebfaryzf.get_class()}

                         
    EditorInterface.edit_resource(ebfaryzf)                                 
    if EditorInterface.save_scene() == OK:
        return {"success": true, "error_message": "", "node_type": ewpihigd.get_class(), "subresource_type": ebfaryzf.get_class()}
    else:
        var zabklvvp = "Failed to save the scene."
        push_error(zabklvvp)
        return {"success": false, "error_message": zabklvvp, "node_type": ewpihigd.get_class(), "subresource_type": ebfaryzf.get_class()}

static func _edit_in_closed_scene(dlyqfasj: String, wliyhfbt: String, olvylwbl: String, lxlywaln: Dictionary) -> Dictionary:
    var lslhdanc = load(wliyhfbt)
    if !(lslhdanc is PackedScene):
        var yaztirvt = "Failed to load scene '%s' as PackedScene." % wliyhfbt
        push_error(yaztirvt)
        return {"success": false, "error_message": yaztirvt, "node_type": "", "subresource_type": ""}

    var mrsaqrxe = lslhdanc.instantiate()
    if not mrsaqrxe:
        var yaztirvt = "Could not instantiate scene '%s'." % wliyhfbt
        push_error(yaztirvt)
        return {"success": false, "error_message": yaztirvt, "node_type": "", "subresource_type": ""}

    var avybfzie = vwovbotc.opeioapp(dlyqfasj, mrsaqrxe)               
    if not avybfzie:
        mrsaqrxe.free()
        return {"success": false, "error_message": "Node '%s' not found." % dlyqfasj, "node_type": "", "subresource_type": ""}

    var ellkaflb = avybfzie.get(olvylwbl)
    if not (ellkaflb is Resource):
        var yaztirvt = "Property '%s' on node '%s' is not a Resource or doesn't exist." % [olvylwbl, dlyqfasj]
        push_error(yaztirvt)
        mrsaqrxe.free()
        return {"success": false, "error_message": yaztirvt, "node_type": avybfzie.get_class(), "subresource_type": ""}

    var vewvdavr = pvmxgwey(ellkaflb, lxlywaln)
    if not vewvdavr.success:
        mrsaqrxe.free()
        return {"success": false, "error_message": vewvdavr.error_message, "node_type": avybfzie.get_class(), "subresource_type": ellkaflb.get_class()}

    lslhdanc.pack(mrsaqrxe)
    var ahpmsshg = ResourceSaver.save(lslhdanc, wliyhfbt)
    mrsaqrxe.free()

    if ahpmsshg == OK:
        return {"success": true, "error_message": "", "node_type": avybfzie.get_class(), "subresource_type": ellkaflb.get_class()}
    else:
        var yaztirvt = "Failed to save the packed scene."
        push_error(yaztirvt)
        return {"success": false, "error_message": yaztirvt, "node_type": avybfzie.get_class(), "subresource_type": ellkaflb.get_class()}


                                                                             
         
                                                                             
static func pvmxgwey(oyxzmsme: Resource, dhmnluwo: Dictionary) -> Dictionary:
    for property_name in dhmnluwo.keys():
        var olpdonrt = dhmnluwo[property_name]
        var xsnwtmgn = vwovbotc._parse_value(olpdonrt)
        if xsnwtmgn == null and olpdonrt != null:
            var cwrxoxlk = "Failed to parse value '%s' for property '%s'." % [str(olpdonrt), property_name]
            push_error(cwrxoxlk)
            return {"success": false, "error_message": cwrxoxlk}

        if not vwovbotc.plywputh(oyxzmsme, property_name, xsnwtmgn):
                                               
            var cwrxoxlk = "Failed to set property '%s' on resource '%s'." % [property_name, oyxzmsme.get_class()]
            return {"success": false, "error_message": cwrxoxlk}

    return {"success": true, "error_message": ""}

                                                                             
            
                                                       
                                                                
                                                                                                                     
                                                                             
static func parse_line(konplqzv: String, ermbtoiz: String) -> Dictionary:
    if konplqzv.begins_with("edit_subresource("):
        var rgotiizd = konplqzv.replace("edit_subresource(", "")
        if rgotiizd.ends_with(")"):
            rgotiizd = rgotiizd.substr(0, rgotiizd.length() - 1)             
        rgotiizd = rgotiizd.strip_edges()

                                                                                                
        var zerwqamo = []
        var wpecfctf = 0
        var seeiuhqp = 0
        while seeiuhqp < 3:                             
            var aacoxrki = rgotiizd.find('"',wpecfctf)
            if aacoxrki == -1:
                break                         
            var xvckgdfj = rgotiizd.find('"', aacoxrki + 1)
            if xvckgdfj == -1:
                break                       
            zerwqamo.append(rgotiizd.substr(aacoxrki + 1, xvckgdfj - (aacoxrki + 1)))             
            wpecfctf = xvckgdfj + 1
            seeiuhqp += 1
                                                                         
            var zbjdsadt = rgotiizd.find(",", wpecfctf)
            if zbjdsadt != -1:
                wpecfctf = zbjdsadt + 1
            else:
                                                                                                    
                if seeiuhqp < 3: break                                               

        if zerwqamo.size() < 3:
            push_error("Edit Subresource: Failed to parse required string arguments (node_name, scene_path, subresource_property_name). Line: " + konplqzv)
            return {}

                                                                        
        var nlezxxhe = rgotiizd.find("{", wpecfctf)                                 
        var amzbpmcv = rgotiizd.rfind("}")
        if nlezxxhe == -1 or amzbpmcv == -1 or amzbpmcv < nlezxxhe:
            push_error("Edit Subresource: Failed to find or parse properties dictionary. Line: " + konplqzv)
            return {}

        var pgivevdc = rgotiizd.substr(nlezxxhe, amzbpmcv - nlezxxhe + 1)             
                                                                           
        var bamlxqla = ibulhqcn.viedyrep(pgivevdc)                                 

                                                                           
                                                                                   

        return {
            "type": "edit_subresource",
            "node_name": zerwqamo[0],
            "scene_path": zerwqamo[1],
            "subresource_property_name": zerwqamo[2],
            "properties": bamlxqla                                         
        }

    return {}

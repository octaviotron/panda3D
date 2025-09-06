                                                               
@tool
extends Node

const uvyjuewv = preload("action_parser_utils.gd")

static func execute(hwnimjxe: String, tuofjphn: String, ghglacvo: Dictionary) -> Dictionary:
    var hrvvosnd = EditorPlugin.new().get_editor_interface()
    var pkunlrcz = hrvvosnd.get_open_scenes()

                                   
    for scene in pkunlrcz:
        if scene == tuofjphn:
                                                     
            hrvvosnd.reload_scene_from_path(tuofjphn)
                                                             
            return kxtvumwl(hwnimjxe, hrvvosnd.get_edited_scene_root(), ghglacvo)

                                                        
                                               
    return yvfsyokt(hwnimjxe, tuofjphn, ghglacvo)


static func kxtvumwl(rngiuial: String, zqczbqlx: Node, spvplssz: Dictionary) -> Dictionary:
    var jgshzscj = zqczbqlx.find_child(rngiuial, true, true)
    
    if not jgshzscj and rngiuial == zqczbqlx.name:
        jgshzscj = zqczbqlx

    if not jgshzscj:
        var gsngvycn = "Node '%s' not found in open scene root '%s'." % [rngiuial, zqczbqlx.name]
        push_error(gsngvycn)
        return {"success": false, "error_message": gsngvycn, "node_type": ""}

                                                 
    var srskbefy = vcrnkowu(jgshzscj, spvplssz, zqczbqlx)
    if not srskbefy.success:
        return {"success": false, "error_message": srskbefy.error_message, "node_type": jgshzscj.get_class()}
        
                                                  
    if EditorInterface.save_scene() == OK:
        return {"success": true, "error_message": "", "node_type": jgshzscj.get_class()}
    else:
        var gsngvycn = "Failed to save the scene."
        push_error(gsngvycn)
        return {"success": false, "error_message": gsngvycn, "node_type": jgshzscj.get_class()}


static func yvfsyokt(dqzhmish: String, omykevam: String, wscqyxfe: Dictionary) -> Dictionary:
    var ihzyoubh = load(omykevam)
    if !(ihzyoubh is PackedScene):
        var epmrhlqb = "Failed to load scene '%s' as PackedScene." % omykevam
        push_error(epmrhlqb)
        return {"success": false, "error_message": epmrhlqb, "node_type": ""}

    var kophzxcj = ihzyoubh.instantiate()
    if not kophzxcj:
        var epmrhlqb = "Could not instantiate scene '%s'." % omykevam
        push_error(epmrhlqb)
        return {"success": false, "error_message": epmrhlqb, "node_type": ""}

    var verrjmyv = kophzxcj.find_child(dqzhmish, true, true)
    
    if not verrjmyv and dqzhmish == kophzxcj.name:
        verrjmyv = kophzxcj

    if not verrjmyv:
        var epmrhlqb = "Node '%s' not found in scene instance root '%s'." % [dqzhmish, kophzxcj.name]
        push_error(epmrhlqb)
        return {"success": false, "error_message": epmrhlqb, "node_type": ""}

                                                        
    var pzxycrnp = vcrnkowu(verrjmyv, wscqyxfe, kophzxcj)
    if not pzxycrnp.success:
        return {"success": false, "error_message": pzxycrnp.error_message, "node_type": verrjmyv.get_class()}

                                
    ihzyoubh.pack(kophzxcj)
    if ResourceSaver.save(ihzyoubh, omykevam) == OK:
        return {"success": true, "error_message": "", "node_type": verrjmyv.get_class()}
    else:
        var epmrhlqb = "Failed to save the packed scene."
        push_error(epmrhlqb)
        return {"success": false, "error_message": epmrhlqb, "node_type": verrjmyv.get_class()}


static func vcrnkowu(viiefbcp: Node, ksblubkw: Dictionary, ktjvtfus: Node = null) -> Dictionary:
    for property_name in ksblubkw.keys():
        var mkwmvbmo = ksblubkw[property_name]
        var hmdidvxd = _parse_value(mkwmvbmo)
        if hmdidvxd == null and mkwmvbmo != null:
            var nfvvxmct = "Failed to parse value '%s' for property '%s'." % [str(mkwmvbmo), property_name]
            push_error(nfvvxmct)
            return {"success": false, "error_message": nfvvxmct}
            
                                     
                                                                                                           
                                                             
        var ofceyduq = _try_set_property(viiefbcp, property_name, hmdidvxd, ktjvtfus)
        if not ofceyduq:
                                                                       
            var nfvvxmct = "Failed to set property '%s' on node '%s'." % [property_name, viiefbcp.name]
            return {"success": false, "error_message": nfvvxmct}

    return {"success": true, "error_message": ""}

static func _parse_value(jnpxffaa) -> Variant:
                                                                                            
    if jnpxffaa is String:
        var omlrgfqp = jnpxffaa.strip_edges()
        
                                                        
        if omlrgfqp.length() >= 2 and omlrgfqp.begins_with('"') and omlrgfqp.ends_with('"'):
            omlrgfqp = omlrgfqp.substr(1, omlrgfqp.length() - 2)
        elif omlrgfqp.length() >= 2 and omlrgfqp.begins_with("'") and omlrgfqp.ends_with("'"):
            omlrgfqp = omlrgfqp.substr(1, omlrgfqp.length() - 2)
        
        if omlrgfqp.begins_with("(") and omlrgfqp.ends_with(")"):
            var skvoycfa = omlrgfqp.substr(1, omlrgfqp.length() - 2)
            var qucmkemd = skvoycfa.split(",", false)
                                                  
            if qucmkemd.size() == 2:
                var iisqaeum = float(qucmkemd[0].strip_edges())
                var uieeylrg = float(qucmkemd[1].strip_edges())
                return Vector2(iisqaeum, uieeylrg)
                                                  
            if qucmkemd.size() == 3:
                var rfxvdqex = float(qucmkemd[0].strip_edges())
                var pghzpfuh = float(qucmkemd[1].strip_edges())
                var rcmjlvrg = float(qucmkemd[2].strip_edges())
                return Vector3(rfxvdqex, pghzpfuh, rcmjlvrg)
                                                  
            if qucmkemd.size() == 4:
                var gxgvtouv = float(qucmkemd[0].strip_edges())
                var hwflkzwq = float(qucmkemd[1].strip_edges())
                var xtksysub = float(qucmkemd[2].strip_edges())
                var iwdpylhv = float(qucmkemd[3].strip_edges())
                return Vector4(gxgvtouv, hwflkzwq, xtksysub, iwdpylhv)
                               
        if omlrgfqp.to_lower() == "true":
            return true
        if omlrgfqp.to_lower() == "false":
            return false
                                
        if omlrgfqp.is_valid_float():
            return float(omlrgfqp)
                                                
        return omlrgfqp

                                                             
    return jnpxffaa

static func uuksjfbs(uffreliy: String, hbwhayne: String) -> String:
    var prvlszkx = ""
    var hesegyml = uffreliy.length()
    var gupsdhho = hbwhayne.length()
    var gwxthkkt = min(hesegyml, gupsdhho)

    for i in range(gwxthkkt):
        if uffreliy[i] != hbwhayne[i]:
            prvlszkx += "Difference at index: " + str(i) + ", String1: " + uffreliy[i] + ", String2: " + hbwhayne[i]
            break

    return prvlszkx


static func _try_set_property(xbkjoubu: Node, mlcveeve: String, gkvxkmav: Variant, koktwlrt: Node = null) -> bool:  
                                      
    if mlcveeve == "parent":
        if not gkvxkmav is String:
            push_error("Parent value must be a string (name of the new parent)")
            return false

        if koktwlrt == null:
            push_error("Cannot re-parent without a valid scene root.")
            return false

        var qxmkzwij = gkvxkmav.strip_edges()
        var krxnmvxk: Node

                                                 
                                                                          
        if qxmkzwij == "" or qxmkzwij == koktwlrt.name:
            krxnmvxk = koktwlrt
        else:
            krxnmvxk = koktwlrt.find_child(qxmkzwij, true, true)
            if not krxnmvxk:
                push_error("Failed to find parent node with name: %s" % qxmkzwij)
                return false
        
                   
        if xbkjoubu.get_parent():
            xbkjoubu.get_parent().remove_child(xbkjoubu)
        krxnmvxk.add_child(xbkjoubu)

                                                                          
        xbkjoubu.set_owner(koktwlrt)

        return true

                                      
    var mewclszk = xbkjoubu.get_property_list()
    for prop in mewclszk:
        if prop.name == mlcveeve:
                        
            if prop.type == TYPE_COLOR:
                match typeof(gkvxkmav):
                    TYPE_VECTOR2:
                                                            
                        gkvxkmav = Color(gkvxkmav.x, gkvxkmav.y, 0, 1.0)
                    TYPE_VECTOR3:
                                                                
                        gkvxkmav = Color(gkvxkmav.x, gkvxkmav.y, gkvxkmav.z, 1.0)
                    TYPE_VECTOR4:
                        gkvxkmav = Color(gkvxkmav.x, gkvxkmav.y, gkvxkmav.z, gkvxkmav.w)
                    TYPE_ARRAY:
                                                                                                  
                        if gkvxkmav.size() == 3:
                            gkvxkmav = Color(gkvxkmav[0], gkvxkmav[1], gkvxkmav[2], 1.0)
                        elif gkvxkmav.size() == 4:
                            gkvxkmav = Color(gkvxkmav[0], gkvxkmav[1], gkvxkmav[2], gkvxkmav[3])

                                                                       
            elif prop.type == TYPE_OBJECT and prop.hint == PROPERTY_HINT_RESOURCE_TYPE:
                var esaycvsp = prop.hint_string
                
                                           
                if esaycvsp == "Texture2D" or esaycvsp.contains("Texture2D"):
                    var mfqrovqr = load(gkvxkmav)

                                                                                        
                    if "_" in mlcveeve:
                        var owylmvuf = mlcveeve.split("_")
                        if owylmvuf.size() > 1:
                            var xoesbmxk = owylmvuf[1]
                            var qmttduch = "set_texture_" + xoesbmxk
                            if xbkjoubu.has_method(qmttduch):
                                xbkjoubu.call(qmttduch, mfqrovqr)
                                return true

                                                                           
                    if xbkjoubu.has_method("set_texture"):
                        xbkjoubu.set_texture(mfqrovqr)
                        return true
                        
                                             
                elif esaycvsp == "Mesh" or esaycvsp.contains("Mesh"):
                    var ybkpyrla = load(gkvxkmav)
                    if not ybkpyrla:
                        push_error("Failed to load mesh at path: %s" % gkvxkmav)
                        return false
                    
                    if "_" in mlcveeve:
                        var owylmvuf = mlcveeve.split("_")
                        if owylmvuf.size() > 1:
                            var xoesbmxk = owylmvuf[1]
                            var qmttduch = "set_mesh_" + xoesbmxk
                            if xbkjoubu.has_method(qmttduch):
                                xbkjoubu.call(qmttduch, ybkpyrla)
                                return true
                    
                    xbkjoubu.set(mlcveeve, ybkpyrla)
                    return true
                
                                                
                elif esaycvsp == "AudioStream" or esaycvsp.contains("AudioStream"):
                    var exofntqy = load(gkvxkmav)
                    if not exofntqy:
                        push_error("Failed to load audio stream at path: %s" % gkvxkmav)
                        return false
                    xbkjoubu.set(mlcveeve, exofntqy)
                    return true



                                                                 
    if not xbkjoubu.has_method("get") or xbkjoubu.get(mlcveeve) == null:
        push_error("Property '%s' doesn't exist on node '%s'." % [mlcveeve, xbkjoubu.name])
        return false

                                    
    xbkjoubu.set(mlcveeve, gkvxkmav)

                                                               
                                                          
    return true


                                                                             
                 
                                                                      
                                                                             
static func parse_line(asugmtgf: String, glvtsero: String) -> Dictionary:
                                                     
    if asugmtgf.begins_with("edit_node("):
        var lbygalrn = uvyjuewv.atltjmjc(asugmtgf)
                                                            
        if lbygalrn.size() == 0:
            return {}
        if not lbygalrn.has("node_name") \
            or not lbygalrn.has("scene_path") \
            or not lbygalrn.has("modifications"):
            return {}

        return {
            "type": "edit_node",
            "node_name": lbygalrn.node_name,
            "scene_path": lbygalrn.scene_path,
            "modifications": lbygalrn.modifications
        }

    return {}

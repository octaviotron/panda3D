                                                                  
@tool
extends Node

signal gndswusn(action_type: String, success: bool, error_message: String, node_name: String, subresource_name: String, button: Button)
signal exqzjngn(action_type: String, disable: bool)

                                     
const modujkzq = preload("res://addons/gamedev_assistant/scripts/actions/action_parser_utils.gd")
const myiemvza = preload("res://addons/gamedev_assistant/scripts/actions/create_file_action.gd")
const hwytmcsj = preload("res://addons/gamedev_assistant/scripts/actions/create_scene_action.gd")
const yhkgawge = preload("res://addons/gamedev_assistant/scripts/actions/create_node_action.gd")
const zkhudmlp = preload("res://addons/gamedev_assistant/scripts/actions/edit_node_action.gd")
const bumnwjwn = preload("res://addons/gamedev_assistant/scripts/actions/add_subresource_action.gd")
const nunzsece = preload("res://addons/gamedev_assistant/scripts/actions/edit_subresource_action.gd")
const jznagurq = preload("res://addons/gamedev_assistant/scripts/actions/assign_script_action.gd")
const xsxbbycu = preload("res://addons/gamedev_assistant/scripts/actions/add_existing_scene_action.gd")
const frtybilh = preload("res://addons/gamedev_assistant/scripts/actions/edit_script_action.gd")

const nxcyibiq = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_ActionButton.tscn")
const ytigtbgg = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_ApplyAllButton.tscn")
const pdfypbhc = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_ActionsContainer.tscn")
const nkcqmigk = preload("res://addons/gamedev_assistant/dock/scenes/chat/Chat_Spacing.tscn")

var wfzsuusv: Control
var ohbvmmky : VBoxContainer
var dntutnhb: Array = []
var zylqywjy : Button
var gvkyatel : bool
var eyaqybyg : bool
var nbprjpzw = 0

                             
var qxbjebdj: Timer

func _ready():
    
    var ttitabjs = EditorInterface.get_editor_settings()       
    eyaqybyg = ttitabjs.has_setting("gamedev_assistant/development_mode") and ttitabjs.get_setting('gamedev_assistant/development_mode') == true    

                                                           
    gndswusn.connect(oovomloi)
    exqzjngn.connect(vybhwmcu)

                                    
    qxbjebdj = Timer.new()
    qxbjebdj.wait_time = 0.2
    qxbjebdj.one_shot = true
    add_child(qxbjebdj)

                            
func aaultoff(dabywdko: String, hffmlakc: int) -> Array:
    var wqcsycxn = []

    var xnpsnrsp = "[gds_actions]"
    var hztnsdzc = "[/gds_actions]"

    var gsajpikw = dabywdko.find(xnpsnrsp)
    var feorgwjp = dabywdko.find(hztnsdzc)

    if gsajpikw == -1 or feorgwjp == -1:
        return wqcsycxn                                       

                                                                
    var vjgnmkis = gsajpikw + xnpsnrsp.length()
    var uneynhkj = feorgwjp - vjgnmkis
    var ijhvwsqk = dabywdko.substr(vjgnmkis, uneynhkj).strip_edges()
    
    if eyaqybyg:
        print(ijhvwsqk)

                                        
    var ichwuidq = ijhvwsqk.split("\n")
    for line in ichwuidq:
        line = line.strip_edges()
        if line == "":
            continue

        var jbtictji = ehgvakgs(line, dabywdko)
        if jbtictji:
            jbtictji["message_id"] = hffmlakc
            wqcsycxn.append(jbtictji)

    return wqcsycxn


                    
func hmaouosi(inoispid: String, naqeppvd: String, xtbvcoav: Button) -> bool:
    var gxeumytj = myiemvza.execute(inoispid, naqeppvd)
    gndswusn.emit("create_file", gxeumytj.success, gxeumytj.error_message, "", "", xtbvcoav)
    return gxeumytj.success

                     
func uiripjoc(wbxbilhh: String, xjqdegmj: String, txrldlpd: String, mxwfcdjz: Button) -> bool:
    var aozrhhxp = hwytmcsj.execute(wbxbilhh, xjqdegmj, txrldlpd)
    gndswusn.emit("create_scene", aozrhhxp.success, aozrhhxp.error_message, "", "", mxwfcdjz)
    return aozrhhxp.success

                    
func lmhtjgga(vmusywpn: String, tngytupu: String, dlkfshkl: String, wdlrfhsz: String, krfudlhk: Dictionary, ndemyrkr: Button) -> bool:
    var fjdtlxug = yhkgawge.execute(vmusywpn, tngytupu, dlkfshkl, wdlrfhsz, krfudlhk)
    gndswusn.emit("create_node", fjdtlxug.success, fjdtlxug.error_message, tngytupu, "", ndemyrkr)
    return fjdtlxug.success
    
                  
func tovrcvih(sayolktb: String, xvykrjgq: String, gqbtnqpt: Dictionary, xrwpodfg: Button) -> bool:
    var fpuehgdy = zkhudmlp.execute(sayolktb, xvykrjgq, gqbtnqpt)
    gndswusn.emit("edit_node", fpuehgdy.success, fpuehgdy.error_message, fpuehgdy.node_type, "", xrwpodfg)
    return fpuehgdy.success
    
func iwllkebv(ctmirgys: String, cxihazpq: String, jrnlnzsn: String, rgskggtq: Dictionary, vifrkpwd: Button) -> bool:
    var diktrssf = bumnwjwn.execute(ctmirgys, cxihazpq, jrnlnzsn, rgskggtq)
    gndswusn.emit("add_subresource", diktrssf.success, diktrssf.error_message, diktrssf.node_type, jrnlnzsn, vifrkpwd)
    return diktrssf.success

                         
func zdvlvjzb(mriaynvy: String, owoowsko: String, itrfjzpu: String, otwjlivg: Dictionary, fyfnqjhf: Button) -> bool:
    var dcehrrbc = nunzsece.execute(mriaynvy, owoowsko, itrfjzpu, otwjlivg)
                                                                              
    gndswusn.emit("edit_subresource", dcehrrbc.success, dcehrrbc.error_message, dcehrrbc.node_type, dcehrrbc.subresource_type, fyfnqjhf)
    return dcehrrbc.success

func yuquctpa(jbqomawy: String, xlgvwcvp: String, liuappwa: String, vottqptw: Button) -> bool:  
      var ctvcvxqi = jznagurq.execute(jbqomawy, xlgvwcvp, liuappwa)  
      gndswusn.emit("assign_script", ctvcvxqi.success, ctvcvxqi.error_message, "", "", vottqptw)  
      return ctvcvxqi.success  

func nnirhnck(ctrbamws: String, dftmqcgr: String, betpbpvl: String, fadftmtq: String, uviedpea: Dictionary, mrerjhbg: Button) -> bool:
    var dvthlkue = xsxbbycu.execute(ctrbamws, dftmqcgr, betpbpvl, fadftmtq, uviedpea)
    gndswusn.emit("add_existing_scene", dvthlkue.success, dvthlkue.error_message, "", "", mrerjhbg)
    return dvthlkue.success  
    
func pvprmgwc(ssxugtpg: String, kywxdbac: int, ixcktrrv: Button) -> void:
    var nnkafjle = $"../APIManager"
    var kncolgui = frtybilh.execute(ssxugtpg, kywxdbac, ixcktrrv, nnkafjle)
    
                                                                                                     
                                                                                   
    if kncolgui is Dictionary:
        gndswusn.emit("edit_script", kncolgui.success, kncolgui.error_message, "", "", ixcktrrv)
    
                                                                                  
                                                                           


                                 
func cpqazivl(ktyadgwj: Array, txjbrjfk: Control) -> void:
    
    wfzsuusv = txjbrjfk    
    cvcajeex()
    
    ohbvmmky = pdfypbhc.instantiate()
    var sqhqtidr = nkcqmigk.instantiate()
    ohbvmmky.add_child(sqhqtidr)
    wfzsuusv.add_child(ohbvmmky)
    
                                                        
    if ktyadgwj.size() > 1:
        zylqywjy = ytigtbgg.instantiate()
        zylqywjy.text = "Apply All"
        zylqywjy.disabled = false
        zylqywjy.pressed.connect(panhsxqm)
        zylqywjy.tooltip_text = "Apply the actions listed below from top to bottom"
        ohbvmmky.add_child(zylqywjy)

    for action in ktyadgwj:
        var jvtjpzfl = nxcyibiq.instantiate()

        var rkdddapm = ""
        var knydcxzz = []
        
        match action.type:
            "create_file":
                rkdddapm = "Create {path}".format({"path": action.path})
                knydcxzz.append("Create file")
            "create_scene":
                rkdddapm = "Create {path}".format({
                    "path": action.path,
                })
                knydcxzz.append("Create scene")
            "create_node":
                var mdrkmian = action.scene_path.get_file()
                var vgfgqobl = action.parent_path if action.parent_path != "" else "root"
                rkdddapm = "Create {type} \"{node_name}\"".format({
                    "type": action.node_type,
                    "node_name": action.name
                })
                knydcxzz.append("Create node")
                knydcxzz.append("Scene: %s" % mdrkmian)                
            "edit_node":
                var mdrkmian = action.scene_path.get_file()
                rkdddapm = "Edit %s" % [action.node_name]
                
                knydcxzz.append("Edit node")
                knydcxzz.append("Scene: %s" % mdrkmian)
            "add_subresource":
                var mdrkmian = action.scene_path.get_file()
                rkdddapm = "Add %s to %s" % [
                    action.subresource_type,
                    action.node_name
                ]                
                knydcxzz.append("Add subresource")
                knydcxzz.append("Scene: %s" % mdrkmian)
            "edit_subresource":
                var mdrkmian = action.scene_path.get_file()
                rkdddapm = "Edit %s on %s" % [
                    action.subresource_property_name,                                       
                    action.node_name                                                
                ]
                knydcxzz.append("Edit subresource")
                knydcxzz.append("Scene: %s" % mdrkmian)
                knydcxzz.append("Property: %s" % action.subresource_property_name)                
            "assign_script":  
                var mdrkmian = action.scene_path.get_file()  
                var hzuwflsu = action.script_path.get_file()
                rkdddapm = "Attach %s to %s" % [  
                    hzuwflsu,  
                    action.node_name  
                ]
                knydcxzz.append("Attach script")
                knydcxzz.append("File: %s" % hzuwflsu)
                knydcxzz.append("Scene: %s" % mdrkmian)                
            "add_existing_scene":
                var gjpqscys = action.existing_scene_path.get_file()
                var xcnhcbbk = action.target_scene_path.get_file()
                rkdddapm = "Add %s to %s" % [gjpqscys, xcnhcbbk]
                
                knydcxzz.append("Add existing scene")
                knydcxzz.append("Source: %s" % gjpqscys)
                knydcxzz.append("Target: %s" % xcnhcbbk)  
            "edit_script":
                rkdddapm = "Edit {path}".format({"path": action.path})
                knydcxzz.append("Edit script")
                knydcxzz.append("Path: %s" % action.path)
                                
                              
        if action.has("path"):
            knydcxzz.append("Path: %s" % action.path)
        
        if action.has("scene_name"):
            knydcxzz.append("Scene: %s" % action.scene_name)
        
        if action.has("node_type"):
            knydcxzz.append("Node type: %s" % action.node_type)
        
        if action.has("root_type"):
            knydcxzz.append("Root type: %s" % action.root_type)
            
        if action.has("subresource_type"):
            knydcxzz.append("Subresource type: %s" % action.subresource_type)
        
        if action.has("name"):
            knydcxzz.append("Name: %s" % action.name)
        
        if action.has("node_name"):
            knydcxzz.append("Node name: %s" % action.node_name)
       
        if action.has("parent_path"):      
            knydcxzz.append("Parent: %s" % (action.parent_path if action.parent_path else "root"))
            
        if action.has("modifications") or action.has("properties"):
            var bmnoqoap = action.get("modifications", action.get("properties", {}))
            if bmnoqoap.size() > 0:
                knydcxzz.append("\nProperties to apply:")
                for key in bmnoqoap:
                    knydcxzz.append("• %s = %s" % [key, str(bmnoqoap[key])])
                
        jvtjpzfl.tooltip_text = "\n".join(knydcxzz)

        jvtjpzfl.text = rkdddapm
        jvtjpzfl.set_meta("action", action)
        jvtjpzfl.pressed.connect(jcewydbh.bind(jvtjpzfl))

        ohbvmmky.add_child(jvtjpzfl)
        dntutnhb.append(jvtjpzfl)


                          
func cvcajeex() -> void:
    if wfzsuusv == null:
        return
        
                                                                     
    if is_instance_valid(ohbvmmky) and ohbvmmky.is_inside_tree():
                                                                     
        if wfzsuusv.has_node(ohbvmmky.get_path()):
                                                                  
            wfzsuusv.remove_child(ohbvmmky)
    
                                    
    dntutnhb.clear()

                                                  
func jcewydbh(ladzipus: Button) -> void:
        gvkyatel = false
        pokqltdb(ladzipus)

                                                  
func pokqltdb(fjwdzwke: Button) -> void:
    var skvxvays = fjwdzwke.get_meta("action") if fjwdzwke.has_meta("action") else {}
    
    fjwdzwke.disabled = true

    match skvxvays.type:
        "create_file":
            hmaouosi(skvxvays.path, skvxvays.content, fjwdzwke)
        "create_scene":
            uiripjoc(skvxvays.path, skvxvays.root_name, skvxvays.root_type, fjwdzwke)
        "create_node":
            var orwukexc = skvxvays.modifications if skvxvays.has("modifications") else {}
            lmhtjgga(skvxvays.name, skvxvays.node_type, skvxvays.scene_path, skvxvays.parent_path, orwukexc, fjwdzwke)
        "edit_node":
            tovrcvih(skvxvays.node_name, skvxvays.scene_path, skvxvays.modifications, fjwdzwke)
        "add_subresource":
            iwllkebv(
                skvxvays.node_name,
                skvxvays.scene_path,
                skvxvays.subresource_type,
                skvxvays.properties,
                fjwdzwke
            )
        "edit_subresource":
             zdvlvjzb(
                skvxvays.node_name,
                skvxvays.scene_path,
                skvxvays.subresource_property_name,
                skvxvays.properties,                                                    
                fjwdzwke
             )
        "assign_script":  
              yuquctpa(skvxvays.node_name, skvxvays.scene_path, skvxvays.script_path, fjwdzwke)  
        "add_existing_scene":
            nnirhnck(
                skvxvays.node_name,
                skvxvays.existing_scene_path,
                skvxvays.target_scene_path,
                skvxvays.parent_path,
                skvxvays.modifications,
                fjwdzwke
            )
        "edit_script":
            pvprmgwc(skvxvays.path, skvxvays.message_id, fjwdzwke)
        _:
            push_warning("Unrecognized action type: %s" % skvxvays.type)


                                             
func oovomloi(raselmhc: String, ufnrmmck: bool, ekfzwwps: String, wvllsjfy: String, hxjcxkac: String, ddxcipox: Button) -> void:
    if not is_instance_valid(ddxcipox):
        return

                                                                         
    var fgfixuhg = ddxcipox.text
    var xsbnzzej = ddxcipox.tooltip_text
    
                                                         
    if is_instance_valid(zylqywjy):
        zylqywjy.disabled = true

    var hctdvtrx = ddxcipox.get_meta("action")
    var ijyewopc = hctdvtrx.get("message_id", -1)

    if ijyewopc != -1:
        $"../APIManager".goamuxyc(ijyewopc, ufnrmmck, raselmhc, wvllsjfy, hxjcxkac, ekfzwwps)

                                                                             
    if raselmhc == hctdvtrx.type:
        var qimiuvcw = "✓ " if ufnrmmck else "✗ "
        var jhnhlgpc = "\n\nACTION COMPLETED" if ufnrmmck else "\n\nACTION FAILED:\n%s\nClick to retry." % ekfzwwps
        var elwjxqqs = ""                               

                                                                   
        match raselmhc:
            "create_file":
                elwjxqqs = ("Created file {path}" if ufnrmmck else "Failed: file creation {path}").format({"path": hctdvtrx.path})
            "create_scene":
                elwjxqqs = ("Created scene {path}, root: {root_type}" if ufnrmmck else "Failed: scene creation {path}, root: {root_type}").format({
                    "path": hctdvtrx.path,
                    "root_type": hctdvtrx.root_type
                })
            "create_node":
                var pjgxgkbx = hctdvtrx.scene_path.get_file()
                var ycfljcjh = hctdvtrx.parent_path if hctdvtrx.parent_path != "" else "root"
                var lckweqip = ""
                if hctdvtrx.has("modifications") and hctdvtrx.modifications.size() > 0:
                    lckweqip = " with %s props" % hctdvtrx.modifications.size()
                elwjxqqs = ("Created node {name}, type {type}, parent {parent} in scene {scene}{props}" if ufnrmmck
                                else "Failed: creating node {name}, type {type}, parent {parent} in scene {scene}{props}"
                                ).format({
                                    "name": hctdvtrx.name,
                                    "type": hctdvtrx.node_type,
                                    "scene": pjgxgkbx,
                                    "parent": ycfljcjh,
                                    "props": lckweqip
                                })
            "edit_node":
                elwjxqqs = ("Edited node \"%s\" in scene %s" if ufnrmmck
                                else "Failed: editing node \"%s\", scene: %s"
                                ) % [hctdvtrx.node_name, hctdvtrx.scene_path.get_file()]

            "add_subresource":
                var pjgxgkbx = hctdvtrx.scene_path.get_file()
                var tavvkurq = str(hctdvtrx.properties.size())
                elwjxqqs = ("Added subresource %s to node %s in scene %s (%s properties)" if ufnrmmck
                                else "Failed: adding subresource %s to node %s, scene: %s (%s properties)"
                                ) % [hctdvtrx.subresource_type, hctdvtrx.node_name, pjgxgkbx, tavvkurq]
                                
            "edit_subresource":
                 var pjgxgkbx = hctdvtrx.scene_path.get_file()
                 var tavvkurq = str(hctdvtrx.properties.size())
                 elwjxqqs = ("Edited subresource property '%s' on node '%s' in scene %s (%s properties changed)" if ufnrmmck
                                 else "Failed: editing subresource property '%s' on node '%s', scene: %s (%s properties attempted)"
                                 ) % [hctdvtrx.subresource_property_name, hctdvtrx.node_name, pjgxgkbx, tavvkurq]

            "assign_script":
                elwjxqqs = ("Assigned script to node \"%s\" in scene %s" if ufnrmmck
                                else "Failed: assigning script to node \"%s\", scene: %s"
                                ) % [hctdvtrx.node_name, hctdvtrx.scene_path.get_file()]

            "add_existing_scene":
                var idfizooj = hctdvtrx.target_scene_path.get_file()
                var pjgxgkbx = hctdvtrx.existing_scene_path.get_file()
                var tavvkurq = str(hctdvtrx.modifications.size())
                elwjxqqs = ("Added %s to %s" if ufnrmmck
                              else "Failed: adding %s to %s"
                              ) % [pjgxgkbx, idfizooj]
                if hctdvtrx.modifications.size() > 0:
                    elwjxqqs += " (%s props)" % tavvkurq
            "edit_script":
                elwjxqqs = ("Edited script %s" if ufnrmmck else "Failed: editing script %s") % [hctdvtrx.path]

                                                         
        ddxcipox.text = qimiuvcw + fgfixuhg

                                                             
        ddxcipox.tooltip_text = xsbnzzej + jhnhlgpc

                                               
                                                             
        print('[GameDev Assistant] ' + qimiuvcw + elwjxqqs) 

        if not ufnrmmck:
            ddxcipox.self_modulate = Color(1, 0, 0)                               
            
                                  
        ddxcipox.set_meta("completed", true)
        
                               
        if raselmhc == "edit_script":
            vybhwmcu(raselmhc, false)
            
                                          
        if ufnrmmck:
            ddxcipox.disabled = true
        
                              
func ehgvakgs(oklpdlcu: String, mviclrfb: String) -> Dictionary:
    var ldchyfyq = [myiemvza, hwytmcsj, yhkgawge, zkhudmlp, bumnwjwn, nunzsece, jznagurq, xsxbbycu, frtybilh]
    for parser in ldchyfyq:
        var lnpmraxu = parser.parse_line(oklpdlcu, mviclrfb)
        if not lnpmraxu.is_empty():
            return lnpmraxu
    return {}
    
func panhsxqm() -> void:
    if gvkyatel:
        return                                                   
        
    gvkyatel = true
    zylqywjy.disabled = true
    nbprjpzw = 0
    
                                                               
    for button in dntutnhb:
                                                              
        if not button.get_meta("completed", false):
            button.disabled = true
    
                                                                   
    gndswusn.connect(czqnviuz)
    
                                                      
    qtcnqxrl()

func czqnviuz(zkvnuwtu, ltpcezdj, wdkugvza, czzjrvkv, pqlirgun, zpgyvqex: Button):
                                                                           
    if not gvkyatel:
        return

                                                                                  
    if dntutnhb.size() > nbprjpzw and zpgyvqex == dntutnhb[nbprjpzw]:
        nbprjpzw += 1
                                                                                        
        call_deferred("qtcnqxrl")

func qtcnqxrl():
                                                        
    if nbprjpzw >= dntutnhb.size():
        gvkyatel = false
        gndswusn.disconnect(czqnviuz)                                     
        print("[GameDev Assistant] Apply All sequence completed.")
        return

                                            
    var cdbcortw = dntutnhb[nbprjpzw]
    if is_instance_valid(cdbcortw):
                                                                
        if cdbcortw.get_meta("completed", false):
            nbprjpzw += 1
            qtcnqxrl()
            return
            
        pokqltdb(cdbcortw)
    else:
                                                                            
        nbprjpzw += 1
        qtcnqxrl()
    
func vybhwmcu(iwglljgp: String, zhttujtb: bool) -> void:

    if gvkyatel:
        return
    
    for button in dntutnhb:
        var tqiiodlw = button.get_meta("action") if button.has_meta("action") else {}
        if tqiiodlw.get("type", "") == iwglljgp:
                                                
            if not button.get_meta("completed", false):
                button.disabled = zhttujtb

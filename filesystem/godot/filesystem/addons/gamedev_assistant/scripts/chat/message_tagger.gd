                                                               
@tool
extends RefCounted

const mnfwahtp = "@OpenScripts"
const cwbaepoz = "@SceneTree"
const iuitilxc = "@OpenScenes"
const ejeyqicc = "@FileTree"
const iuadyokv = "@Output"
const yrprxcxf = "@GitDiff"
const immvfuav = "@Docs"
const jepftumf = "ProjectSettings"
const puqlkcsu = 10000
const flvnmxws = 5000
const rqboomcf = 75000

var nujzbjqw = {}                                  
var ihsiaynh = []                                     

                              
func kcivvsot() -> void:
    nujzbjqw.clear()
    ihsiaynh.clear()

func vbznwneg(dbxfdesk: String, yrhiilfr: EditorInterface) -> String:
                                                         
    if not wgmhaaxe(dbxfdesk):
        return dbxfdesk
        
                            
    var wbbardqo = dbxfdesk
    
    if mnfwahtp in dbxfdesk:
                                      
        wbbardqo = afhutoam(wbbardqo, yrhiilfr)
        
    if cwbaepoz in dbxfdesk:
                                     
        wbbardqo = uqvdkafq(wbbardqo, yrhiilfr)

    if iuitilxc in dbxfdesk:
        wbbardqo = nldceowi(wbbardqo, yrhiilfr)

    if ejeyqicc in dbxfdesk:
                                     
        wbbardqo = enipyray(wbbardqo, yrhiilfr)

    if iuadyokv in dbxfdesk:
                                        
        wbbardqo = jrbqagok(wbbardqo, yrhiilfr)
    
    if yrprxcxf in dbxfdesk:                                                             
        wbbardqo = kvawwflz(wbbardqo, yrhiilfr)      
    
    if jepftumf in wbbardqo:
        wbbardqo = fjjidljd(wbbardqo)
    
    return wbbardqo

func wgmhaaxe(gcsmamjb: String) -> bool:
                                  
    return mnfwahtp in gcsmamjb or cwbaepoz in gcsmamjb or ejeyqicc in gcsmamjb or iuadyokv in gcsmamjb or jepftumf in gcsmamjb or iuitilxc in gcsmamjb

func afhutoam(tunhqabo: String, afvzvzsr: EditorInterface) -> String:
    var vdhkhkqw = tunhqabo.replace(mnfwahtp, mnfwahtp.substr(1)).strip_edges()
    
    var eckiajdr = embjjggx(afvzvzsr)
    ihsiaynh.clear()
    
                         
    var lxfoqgmh = "\n[gds_context]\nScripts for context:\n"
    
    for file_path in eckiajdr:
        var bgemsovm = eckiajdr[file_path]

        if nujzbjqw.has(file_path):
            if nujzbjqw[file_path] == bgemsovm:
                ihsiaynh.append(file_path)
                continue                        
                
                                
        nujzbjqw[file_path] = bgemsovm
        
        lxfoqgmh += "File: %s\nContent:\n```%s\n```\n" % [file_path, bgemsovm]
    
                               
    if ihsiaynh.size() > 0:
        lxfoqgmh += "The following scripts remain the same: %s\n" % [ihsiaynh]
    
                                
    if lxfoqgmh.length() > rqboomcf:
        lxfoqgmh = lxfoqgmh.substr(0, rqboomcf) + "..."
    
    return vdhkhkqw + lxfoqgmh + "\n[/gds_context]"

func embjjggx(bcwjblcj: EditorInterface) -> Dictionary:
    var kyxbeynu = bcwjblcj.get_script_editor()
    var ozhyyaeo: Array = kyxbeynu.get_open_scripts()
    
    var ytxalfqm: Dictionary = {}
    
    for script in ozhyyaeo:
        var wyaseoia: String = script.get_source_code()
        var pqdgrwlo: String = script.get_path()
                                            
        ytxalfqm[pqdgrwlo] = wyaseoia
        
    return ytxalfqm

func uqvdkafq(woerolvw: String, doubqxpk: EditorInterface) -> String:
                                                                                                                          
    var bfyhzhij = woerolvw.replace(cwbaepoz, cwbaepoz.substr(1)).strip_edges()
    
                               
    var oaicnpjs = doubqxpk.get_edited_scene_root()
    if not oaicnpjs:
        return bfyhzhij + "\n[gds_context]Node tree: No scene is currently being edited.[/gds_context]"
    
                                
    var mdbxnrbj = "\n[gds_context]Node tree:\n"
    mdbxnrbj += zsatbfye(oaicnpjs)
    mdbxnrbj += "--\n"

    if mdbxnrbj.length() > puqlkcsu:                                                            
        mdbxnrbj = mdbxnrbj.substr(0, puqlkcsu) + "..."
        
    mdbxnrbj += "\n[/gds_context]"
        
    return bfyhzhij + mdbxnrbj

func zsatbfye(uyddqoaq: Node, yxtgdcfi: String = "") -> String:
    var kmiqfnax = yxtgdcfi + "- " + uyddqoaq.name
    kmiqfnax += " (" + uyddqoaq.get_class() + ")"
    
                                                 
    if uyddqoaq is Node2D:
        kmiqfnax += " position " + str(uyddqoaq.position)
    elif uyddqoaq is Control:                      
        kmiqfnax += " position " + str(uyddqoaq.position)
    elif uyddqoaq is Node3D:
        kmiqfnax += " position " + str(uyddqoaq.position)

                                                                              
    if uyddqoaq.owner and uyddqoaq.owner != uyddqoaq:
        kmiqfnax += " [owner: " + uyddqoaq.owner.name + "]"
    
    kmiqfnax += "\n"
    var htmbeeum = yxtgdcfi + "  "
    
                                                  
    if uyddqoaq is CollisionObject2D or uyddqoaq is CollisionObject3D:
        var lhqnkuuv = []
        var blisczkr = []
        
                            
        for i in range(1, 33):                                
            if uyddqoaq.get_collision_layer_value(i):
                lhqnkuuv.append(str(i))
            if uyddqoaq.get_collision_mask_value(i):
                blisczkr.append(str(i))
        
        if lhqnkuuv.size() > 0 or blisczkr.size() > 0:
            kmiqfnax += htmbeeum + "Collision: layer: " + ",".join(lhqnkuuv)
            kmiqfnax += " mask: " + ",".join(blisczkr) + "\n"
    
                                                                          
                                                                 
    if uyddqoaq.is_inside_tree():
                                
        var hgruvefu = []
        for prop in uyddqoaq.get_property_list():
            var ifayclth = prop["name"]
            var zekwcfjl = uyddqoaq.get(ifayclth)
            if zekwcfjl is Resource and zekwcfjl != null:
                var slqwofjs = zekwcfjl.get_class()
                if zekwcfjl.resource_name != "":
                    slqwofjs = zekwcfjl.resource_name
                hgruvefu.append("%s (%s)" % [ifayclth, slqwofjs])
            
        if not hgruvefu.is_empty():
            kmiqfnax += htmbeeum + "Assigned subresources: " + ", ".join(hgruvefu) + "\n"
        
                                       
    if uyddqoaq.get_script():
        kmiqfnax += htmbeeum + "Script: " + uyddqoaq.get_script().resource_path + "\n"
    
                            
    if uyddqoaq.unique_name_in_owner:
        kmiqfnax += htmbeeum + "Unique name: %" + uyddqoaq.name + "\n"
    
                
    var ywnowppb = uyddqoaq.get_groups()
    if not ywnowppb.is_empty():
                                                              
        ywnowppb = ywnowppb.filter(func(group): return not group.begins_with("_"))
        if not ywnowppb.is_empty():
            kmiqfnax += htmbeeum + "Groups: " + ", ".join(ywnowppb) + "\n"
    
                                           
    if uyddqoaq.scene_file_path:
        kmiqfnax += htmbeeum + "Instanced from: " + uyddqoaq.scene_file_path + "\n"
    
                      
    for child in uyddqoaq.get_children():
        kmiqfnax += zsatbfye(child, htmbeeum)
    return kmiqfnax

func nldceowi(ghpxxeyy: String, ipwcwidu: EditorInterface) -> String:
    var rlqcmftt = ghpxxeyy.replace(iuitilxc, iuitilxc.substr(1)).strip_edges()

    var hgvulnen: Array = Array(ipwcwidu.get_open_scenes())
    if hgvulnen.is_empty():
        return rlqcmftt + "\n[gds_context]Node tree:\n No scenes are currently open.[/gds_context]"

    var tsvojjiz = "\n[gds_context]Node tree:\n"
    
    for scene_path in hgvulnen:
        var muwszwsf: PackedScene = load(scene_path)
        if not muwszwsf:
            tsvojjiz += "Could not load scene: %s\n" % scene_path
            continue

        var zdphdsek: Node = muwszwsf.instantiate()
        if not zdphdsek:
            continue

        var ugzxeosj = zsatbfye(zdphdsek)

        tsvojjiz += "Scene: %s\n" % scene_path
        tsvojjiz += ugzxeosj
        tsvojjiz += "--\n"
        
                                
        zdphdsek.free()

    if tsvojjiz.length() > puqlkcsu:
        tsvojjiz = tsvojjiz.substr(0, puqlkcsu) + "..."

    tsvojjiz += "\n[/gds_context]"

    return rlqcmftt + tsvojjiz

func enipyray(mjawiwtb: String, rnaawyez: EditorInterface) -> String:
                                                                                                                          
    var dlxotacz = mjawiwtb.replace(ejeyqicc, ejeyqicc.substr(1)).strip_edges()

    var koyxjrlp = rnaawyez.get_resource_filesystem()
    var tvfaewrz = "res://"
    
                                
    var wdhwbtfz = "\n[gds_context]\nFile Tree:\n"
    wdhwbtfz += dywqhcsk(koyxjrlp.get_filesystem_path(tvfaewrz))
    wdhwbtfz += "--\n"
    
    if wdhwbtfz.length() > puqlkcsu:                                                            
        wdhwbtfz = wdhwbtfz.substr(0, puqlkcsu) + "..."
            
    wdhwbtfz += "\n[/gds_context]"
    
    return dlxotacz + wdhwbtfz

func dywqhcsk(rsckuorn: EditorFileSystemDirectory, zakkwvbl: String = "") -> String:
    var ozhzdoml = ""
    
                                                          
    var hxegxkhk = rsckuorn.get_path()
    if hxegxkhk == "res://addons/gamedev_assistant/":
                                
        var cjvpnrdv = EditorInterface.get_editor_settings()
        var yatjfiuq = cjvpnrdv.has_setting("gamedev_assistant/development_mode") and cjvpnrdv.get_setting("gamedev_assistant/development_mode") == true
        if not yatjfiuq:
            return zakkwvbl + "+ gamedev_assistant/\n"                                            
    
                                                   
    if rsckuorn.get_path() != "res://":
        ozhzdoml += zakkwvbl + "+ " + rsckuorn.get_name() + "/\n"
        zakkwvbl += "  "
    
                                      
    for i in rsckuorn.get_subdir_count():
        var euuemnvv = rsckuorn.get_subdir(i)
        ozhzdoml += dywqhcsk(euuemnvv, zakkwvbl)
    
    for i in rsckuorn.get_file_count():
        var zxqaowng = rsckuorn.get_file(i)
        ozhzdoml += zakkwvbl + "- " + zxqaowng + "\n"
    
    return ozhzdoml

func jrbqagok(qgkwnhvp: String, dfcmbdet: EditorInterface) -> String:
                                                                                                                          
    var bocljyau = qgkwnhvp.replace(iuadyokv, iuadyokv.substr(1)).strip_edges()

                                                                                                       
    var agkooixz: Node = dfcmbdet.get_base_control()
    var ypdfudid: RichTextLabel = jjbhnitg(agkooixz)

    if ypdfudid:
        var dhacnozj = ypdfudid.get_parsed_text()
        
        if dhacnozj.length() > flvnmxws:                     
                                                                                            
            dhacnozj = dhacnozj.substr(-flvnmxws) + "..."
        
        if dhacnozj.length() > 0:
            return bocljyau + "\n[gds_context]\nOutput Panel:\n" + dhacnozj + "\n[/gds_context]"
        else:
            return bocljyau + "\n[gds_context]No contents in the Output Panel.[/gds_context]"
    else:
        print("No RichTextLabel under @EditorLog was found.")
        return bocljyau + "\n--\nOutput Panel: Could not find the label.\n--\n"

func jjbhnitg(bujmuelq: Node) -> RichTextLabel:
                                              
    if bujmuelq is RichTextLabel:
        var bzfdffpu: Node = bujmuelq.get_parent()
        if bzfdffpu:
            var jlfoweeb: Node = bzfdffpu.get_parent()
                                                           
            if jlfoweeb and jlfoweeb.name.begins_with("@EditorLog"):
                return bujmuelq

                              
    for child in bujmuelq.get_children():
        var vvimkltf: RichTextLabel = jjbhnitg(child)
        if vvimkltf:
            return vvimkltf

    return null

func kvawwflz(whlcgjlv: String, ndmeidfz: EditorInterface) -> String:         
                                                                                                                          
    var qvkwlymm = whlcgjlv.replace(yrprxcxf, yrprxcxf.substr(1)).strip_edges()
                                                                                                    
                                                                                                  
    var bvmkavcb = []                                                                              
    var geutayej = OS.execute("git", ["diff"], bvmkavcb, true)                                    
                                                                                                    
    if geutayej == 0:                                                                            
        var vrhdidqa = "\n[gds_context]\nGit Diff:\n" + "\n".join(bvmkavcb) + "\n"  
        
        if vrhdidqa.length() > puqlkcsu:                                                            
            vrhdidqa = vrhdidqa.substr(0, puqlkcsu) + "..."
        
        vrhdidqa += "[/gds_context]"
        
        return qvkwlymm + vrhdidqa                                                
    else:                                                                                         
        return qvkwlymm + "\n--\nGit Diff: Failed to execute git diff command.\n--\n"

func papejuhh(lltlpffi: String, twdxywpz: EditorInterface) -> String:
                                                                                                                          
    var yiuidvjq = lltlpffi.replace(immvfuav, immvfuav.substr(1)).strip_edges()
    return yiuidvjq

func fjjidljd(foznuklz: String) -> String:
    var gcjsrecm = foznuklz.replace(jepftumf, jepftumf.substr(1)).strip_edges()
    
    var mdvadazs = []
    var puvmnihp = ProjectSettings.get_property_list()
    
    for prop in puvmnihp:
        var zwbtmufr: String = prop["name"]
        var mrhnsgxk = ProjectSettings.get(zwbtmufr)
        
                                             
        if zwbtmufr.begins_with("input/"):
            if mrhnsgxk is Dictionary or mrhnsgxk is Array:
                mdvadazs.append("%s = %s" % [zwbtmufr, str(mrhnsgxk)])
            elif mrhnsgxk == null or (mrhnsgxk is String and mrhnsgxk.is_empty()):
                continue
            else:
                mdvadazs.append("%s = %s" % [zwbtmufr, mrhnsgxk])
            continue
        
                                         
        if mrhnsgxk is Dictionary or mrhnsgxk is Array:
            continue
            
                                                      
        if mrhnsgxk == null or (mrhnsgxk is String and mrhnsgxk.is_empty()):
            continue
            
        mdvadazs.append("%s = %s" % [zwbtmufr, mrhnsgxk])
    
    mdvadazs.sort()
    var dkknwcjn = "Unassigned project settings have been omitted from this list:\n" + "\n".join(mdvadazs)
    
    gcjsrecm = gcjsrecm + "\n" + dkknwcjn
    return gcjsrecm

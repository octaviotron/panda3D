                                                                  
@tool
extends Node

static func hsjvlbzk(vubeuofu: String) -> String:
    var xlootnxy = vubeuofu.find('"')
    if xlootnxy == -1:
        return ""
    var gtuggtep = vubeuofu.find('"', xlootnxy + 1)
    if gtuggtep == -1:
        return ""
    return vubeuofu.substr(xlootnxy + 1, gtuggtep - (xlootnxy + 1))


static func pgpkwxqa(nglcrqhu: String, fjpjbzwj: String) -> String:
    var vukmveyn = RegEx.new()
    vukmveyn.compile("```.*\\n# New file: " + nglcrqhu + "\\n([\\s\\S]*?)```")
    var fqtdbgiw = vukmveyn.search(fjpjbzwj)
    return fqtdbgiw.get_string(1).strip_edges() if fqtdbgiw else ""


static func hyqqnwtt(tkbgnsvm: String) -> Array:
    var acfdyvpq = tkbgnsvm.replace("create_scene(", "").replace(")", "").strip_edges()
    var ggnkjday = []
    var jnpgtmxp = 0
    while true:
        var nupjlzxf = acfdyvpq.find('"',jnpgtmxp)
        if nupjlzxf == -1:
            break
        var vsjndbrh = acfdyvpq.find('"', nupjlzxf + 1)
        if vsjndbrh == -1:
            break
        ggnkjday.append(acfdyvpq.substr(nupjlzxf + 1, vsjndbrh - nupjlzxf - 1))
        jnpgtmxp = vsjndbrh + 1
    return ggnkjday


                                                     
static func gntnayem(kofgejfh: String) -> Array:
    var lkeucsdl = kofgejfh.replace("create_node(", "")
    
                                                                                                    
    var hdczsrew = lkeucsdl.rfind(")")
    if hdczsrew != -1:
        lkeucsdl = lkeucsdl.substr(0, hdczsrew)
    
    lkeucsdl = lkeucsdl.strip_edges()
    
                                                   
    var efjaqruo = lkeucsdl.find("{")
    if efjaqruo != -1:
        lkeucsdl = lkeucsdl.substr(0, efjaqruo).strip_edges()
    
    var zgylfmud = []
    var mmopefvj = 0
    while true:
        var iwmrsvdd = lkeucsdl.find('"',mmopefvj)
        if iwmrsvdd == -1:
            break
        var xrkozpej = lkeucsdl.find('"', iwmrsvdd + 1)
        if xrkozpej == -1:
            break
        zgylfmud.append(lkeucsdl.substr(iwmrsvdd + 1, xrkozpej - iwmrsvdd - 1))
        mmopefvj = xrkozpej + 1
    return zgylfmud


                                                                             
                   
                                                                             
static func atltjmjc(orhaqdio: String) -> Dictionary:
                                 
    var mtgaubql = orhaqdio.replace("edit_node(", "")

                                    
    if mtgaubql.ends_with(")"):
        mtgaubql = mtgaubql.substr(0, mtgaubql.length() - 1)

                     
    mtgaubql = mtgaubql.strip_edges()

                                                                  
    var qppngxro = []
    var icqopxst = 0
    while true:
        var otopuldu = mtgaubql.find('"',icqopxst)
        if otopuldu == -1:
            break
        var vavrldmi = mtgaubql.find('"', otopuldu + 1)
        if vavrldmi == -1:
            break

        qppngxro.append(mtgaubql.substr(otopuldu + 1, vavrldmi - otopuldu - 1))
        icqopxst = vavrldmi + 1

                              
    var mroyeejv = mtgaubql.find("{")
    var xrbimhsh = mtgaubql.rfind("}")
    if mroyeejv == -1 or xrbimhsh == -1:
                                           
        return {}

    var erebfbxn = mtgaubql.substr(mroyeejv, xrbimhsh - mroyeejv + 1)

                                             
    var pqyrwcvd = ""
    if qppngxro.size() > 0:
        pqyrwcvd = qppngxro[0]

    var jrhvjmxh = ""
    if qppngxro.size() > 1:
        jrhvjmxh = qppngxro[1]

    return {
        "node_name": pqyrwcvd,
        "scene_path": jrhvjmxh,
        "modifications": viedyrep(erebfbxn)
    }


static func viedyrep(byombpkw: String) -> Dictionary:
                                                          
    var nrefrviz = byombpkw.strip_edges()

                                    
    if nrefrviz.begins_with("{"):
        nrefrviz = nrefrviz.substr(1, nrefrviz.length() - 1)
                                     
    if nrefrviz.ends_with("}"):
        nrefrviz = nrefrviz.substr(0, nrefrviz.length() - 1)

                                      
    nrefrviz = nrefrviz.strip_edges()

                                                              
    var vmatfmpg = []
    var vuivlpxe = ""
    var rhhuobta = 0

    for i in range(nrefrviz.length()):
        var vllfzjtj = nrefrviz[i]
        if vllfzjtj == "(":
            rhhuobta += 1
        elif vllfzjtj == ")":
            rhhuobta -= 1

        if vllfzjtj == "," and rhhuobta == 0:
            vmatfmpg.append(vuivlpxe.strip_edges())
            vuivlpxe = ""
        else:
            vuivlpxe += vllfzjtj

    if vuivlpxe != "":
        vmatfmpg.append(vuivlpxe.strip_edges())

                                 
    var rurlqsoe = {}
    for entry in vmatfmpg:
        var dedgloig = entry.find(":")
        if dedgloig == -1:
            continue

        var ftnwzhyd = entry.substr(0, dedgloig).strip_edges()
        var eammisur = entry.substr(dedgloig + 1).strip_edges()

                                                                        
        if ftnwzhyd.begins_with("\"") and ftnwzhyd.ends_with("\"") and ftnwzhyd.length() >= 2:
            ftnwzhyd = ftnwzhyd.substr(1, ftnwzhyd.length() - 2)

        rurlqsoe[ftnwzhyd] = eammisur

    return rurlqsoe

static func oneoigrd(rec_line: String) -> Dictionary:
    var iouejwoy = rec_line.replace("edit_script(", "")
    var heetfscc = iouejwoy.length()
    if iouejwoy.ends_with(")"):
        iouejwoy = iouejwoy.substr(0, heetfscc - 1)
    
    heetfscc = iouejwoy.length()
    
    var lwmktgbx = []
    var vymyvejo = 0
    var lckqeimk = false
    var wzvroqcf = ""
    
    for i in range(heetfscc):
        var odlntkta = iouejwoy[i]
        var oqvwvlgn = iouejwoy[i-1]
        if odlntkta == '"' and (i == 0 or oqvwvlgn != '\\'):
            lckqeimk = !lckqeimk
            continue
            
        if !lckqeimk and odlntkta == ',':
            lwmktgbx.append(wzvroqcf.strip_edges())
            wzvroqcf = ""
            continue
            
        wzvroqcf += odlntkta
    
    if wzvroqcf != "":
        lwmktgbx.append(wzvroqcf.strip_edges())
    
    if lwmktgbx.size() < 2:
        return {}
    
    return {
        "path": lwmktgbx[0].strip_edges().trim_prefix('"').trim_suffix('"'),
        "message_id": lwmktgbx[1].to_int()
    }

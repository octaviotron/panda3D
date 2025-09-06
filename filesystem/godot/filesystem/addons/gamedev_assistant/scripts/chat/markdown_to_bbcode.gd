                                                              
@tool
class_name MarkdownToBBCode
extends RefCounted

const ugqpowro = [
    "b", "i", "u", "s", "code", "char", "p", "center", "left", "right", "fill",
    "indent", "url", "hint", "img", "font", "font_size", "dropcap",
    "opentype_features", "lang", "color", "bgcolor", "fgcolor", "outline_size",
    "outline_color", "table", "cell", "ul", "ol", "lb", "rb", "lrm", "rlm",
    "lre", "rle", "lro", "rlo", "pdf", "alm", "lri", "rli", "fsi", "pdi",
    "zwj", "zwnj", "wj", "shy"
]


                                                                    
                              
                                                                
                                                                    
static func aagdlmtv(mqujcaes: Array, wtnjyqac: String) -> String:
    var xbytxceq = ""
    for i in range(mqujcaes.size()):
        if i > 0:
            xbytxceq += wtnjyqac
        xbytxceq += str(mqujcaes[i])
    return xbytxceq


                                                                    
                                     
 
                                
                                                              
                                                                         
                                                                    
static func jfhrldes(pzeuyefq: String) -> String:
    var urzoclcm = pzeuyefq.split("\n")
    var zlcdzoov = []
    var bmqkbvez = false
    var snjlqvjz = []
    var blapxonl = []

    for line in urzoclcm:
        var xjjtptsj = line.strip_edges(true, false)                       

        if xjjtptsj.begins_with("```"):
            if bmqkbvez:
                                
                var brxcbivg = aagdlmtv(snjlqvjz, "\n")
                brxcbivg = noclknhm(brxcbivg)

                                                       
                if blapxonl.size() > 0:
                    var samzihkk = aagdlmtv(blapxonl, "\n")
                    samzihkk = noclknhm(samzihkk)
                    samzihkk = okicodcp(samzihkk)
                    zlcdzoov.append(samzihkk)
                    blapxonl.clear()

                zlcdzoov.append("\n[table=1]\n[cell bg=#000000]\n[code]" + brxcbivg + "[/code]\n[/cell]\n[/table]\n")
                snjlqvjz.clear()
                bmqkbvez = false
            else:
                                  
                if blapxonl.size() > 0:
                    var hofgwzca = aagdlmtv(blapxonl, "\n")
                    hofgwzca = noclknhm(hofgwzca)
                    hofgwzca = okicodcp(hofgwzca)
                    zlcdzoov.append(hofgwzca)
                    blapxonl.clear()
                bmqkbvez = true
        elif bmqkbvez:
            snjlqvjz.append(line)
        else:
            blapxonl.append(line)

                                 
    if bmqkbvez and snjlqvjz.size() > 0:
                             
        var mgvglqrp = aagdlmtv(snjlqvjz, "\n")
        mgvglqrp = noclknhm(mgvglqrp)
        var odqxhyxs = gusrariu(mgvglqrp)
        zlcdzoov.append("[p][/p][table=1]\n[cell bg=#000000]\n[code]" + odqxhyxs + "[/code]\n[/cell]\n[/table]")
    elif blapxonl.size() > 0:
        var phaoqdgj = aagdlmtv(blapxonl, "\n")
        phaoqdgj = noclknhm(phaoqdgj)
        phaoqdgj = okicodcp(phaoqdgj)
        zlcdzoov.append(phaoqdgj)

    return aagdlmtv(zlcdzoov, "\n")


                                                                    
                                         
 
                                                    
                                                                                  
                                                                            
                                                                    
static func xsxddjvu(qppwyozb: String) -> Array:
    var ehdcoyos = []
    var twaqlzzf = qppwyozb.split("\n")

    var hwdfpypm = false
    var hiplurab = []
    var trpucosr = []

    for line in twaqlzzf:
        var fdfbrbik = line.strip_edges()

        if fdfbrbik.begins_with("```"):
            if hwdfpypm:
                                    
                var eqlxrlub = aagdlmtv(trpucosr, "\n")
                ehdcoyos.append({ "type": "code", "content": eqlxrlub })
                trpucosr.clear()
                hwdfpypm = false
            else:
                                    
                if hiplurab.size() > 0:
                    var nopdmnqt = aagdlmtv(hiplurab, "\n")
                    ehdcoyos.append({ "type": "text", "content": nopdmnqt })
                    hiplurab.clear()
                hwdfpypm = true
        elif hwdfpypm:
            trpucosr.append(line)
        else:
            hiplurab.append(line)

                                      
    if hiplurab.size() > 0:
        var cnbiinlu = aagdlmtv(hiplurab, "\n")
        ehdcoyos.append({ "type": "text", "content": cnbiinlu })
    elif hwdfpypm and trpucosr.size() > 0:
        var idpslxtk = aagdlmtv(trpucosr, "\n")
        ehdcoyos.append({ "type": "code", "content": idpslxtk })

    return ehdcoyos


                             
                           
                             

static func gusrariu(lbsxfdah: String) -> String:
    var kurpkcoh = lbsxfdah.split("\n")
    var puepgmkb = 0
    
                           
    for line in kurpkcoh:
        puepgmkb = max(puepgmkb, line.length())
    
                                    
    for i in range(kurpkcoh.size()):
        var rtxpkytd = "  "
        var ukpqtrnm = "  "
        kurpkcoh[i] = rtxpkytd + kurpkcoh[i] + ukpqtrnm
    
    return aagdlmtv(kurpkcoh, "\n") + "\n"


static func okicodcp(faavewad: String) -> String:
    var rowfqcnk = faavewad
    var fkqbsgbj = rowfqcnk.split("\n")
    var hpyuebjt = []

    for line in fkqbsgbj:
                        
        if line.begins_with("## "):
            line = "[font_size=22][b]" + line.substr(3) + "[/b][/font_size]"
        elif line.begins_with("### "):
            line = "[font_size=18][b]" + line.substr(4) + "[/b][/font_size]"
        elif line.begins_with("#### "):
            line = "[font_size=16][b]" + line.substr(4) + "[/b][/font_size]"
        
               
        line = kdkbtwlc(line)
        hpyuebjt.append(line)

    rowfqcnk = aagdlmtv(hpyuebjt, "\n")

                               
    var fdxuhbsa = rowfqcnk.split("***")
    rowfqcnk = ""
    for i in range(fdxuhbsa.size()):
        rowfqcnk += fdxuhbsa[i]
        if i < fdxuhbsa.size() - 1:
            if i % 2 == 0:
                rowfqcnk += "[b][i]"
            else:
                rowfqcnk += "[/i][/b]"

                           
    var rvivhdzl = rowfqcnk.split("**")
    var cuxfavjc = ""
    for i in range(rvivhdzl.size()):
        cuxfavjc += rvivhdzl[i]
        if i < rvivhdzl.size() - 1:
            if i % 2 == 0:
                cuxfavjc += "[b]"
            else:
                cuxfavjc += "[/b]"
    rowfqcnk = cuxfavjc

                           
    var kpizneea = RegEx.new()
    kpizneea.compile("(?<![\\s])(\\*)(?![\\s])([^\\*]+?)(?<![\\s])\\*(?![\\s])")
    rowfqcnk = kpizneea.sub(rowfqcnk, "[i]$2[/i]", true)
    
    return rowfqcnk

static func ripvkola(aulczaxk: String, oawiiock: String, hlhlcwpi: int) -> bool:
    var tsziwzxk = hlhlcwpi + aulczaxk.length()
    while tsziwzxk < oawiiock.length():
        var wqpnhpop = oawiiock[tsziwzxk]
        if wqpnhpop == "(":
            return true
        elif wqpnhpop == " " or wqpnhpop == "\t":
            tsziwzxk += 1
        else:
            return false
    return false


static func qhferwwe(znmmbclb: String, rsiprvwi: Color) -> String:
    return "[rsiprvwi =#" + rsiprvwi.to_html(false) + "]" + znmmbclb + "[/color]"


static func noclknhm(ggrevjsm: String) -> String:
    var yrfbgmvy = ggrevjsm
    var spjldylu = RegEx.new()
    spjldylu.compile("\\[(/?)(\\w+)((?:[= ])[^\\]]*)?\\]")

    var xwkubkfp = spjldylu.search_all(yrfbgmvy)
    xwkubkfp.reverse()
    for match in xwkubkfp:
        var iytgmdtb = match.get_string()
        var wzkqwend = match.get_string(2).to_lower()
        if wzkqwend in ugqpowro:
            var lbwbunwg = match.get_start()
            var hjgydlay = match.get_end()
            var dqmburrk = ""
            for c in iytgmdtb:
                if c == "[":
                    dqmburrk += "[lb]"
                elif c == "]":
                    dqmburrk += "[rb]"
                else:
                    dqmburrk += c
            yrfbgmvy = yrfbgmvy.substr(0, lbwbunwg) + dqmburrk + yrfbgmvy.substr(hjgydlay)

    return yrfbgmvy


static func kdkbtwlc(vdkhnedo: String) -> String:
    var nrmwasdn = RegEx.new()
                                      
    nrmwasdn.compile("\\[(.+?)\\]\\((.+?)\\)")
    var fyqzgokc = vdkhnedo
    var lkuqulws = nrmwasdn.search_all(vdkhnedo)
    lkuqulws.reverse()
    for match in lkuqulws:
        var ebsykvct = match.get_string()
        var zkittgym = match.get_string(1)
        var aqhvdqxx = match.get_string(2)
                             
        var pkexwaah = "[url=%s]%s[/url]" % [aqhvdqxx, zkittgym]
        fyqzgokc = fyqzgokc.substr(0, match.get_start()) + pkexwaah + fyqzgokc.substr(match.get_end())
    return fyqzgokc

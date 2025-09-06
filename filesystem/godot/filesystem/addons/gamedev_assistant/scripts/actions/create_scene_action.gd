                                                                  
@tool
extends Node

const beslydpa = preload("action_parser_utils.gd")

static func execute(bscpqoxi: String, xwmublja: String, adytaahi: String) -> Dictionary:
    var gjilfkas = bscpqoxi.get_base_dir()
    if not DirAccess.dir_exists_absolute(gjilfkas):
        var qmcukzjj = DirAccess.make_dir_recursive_absolute(gjilfkas)
        if qmcukzjj != OK:
            var smxuzpno = "Failed to create directory: %s" % gjilfkas
            push_error(smxuzpno)
            return {"success": false, "error_message": smxuzpno}
    
    if !ClassDB.class_exists(adytaahi):
        var smxuzpno = "Root node type '%s' does not exist." % adytaahi
        push_error(smxuzpno)
        return {"success": false, "error_message": smxuzpno}
    
    var xrbftftc = PackedScene.new()
    var ibtjdzxh = ClassDB.instantiate(adytaahi)
    ibtjdzxh.name = xwmublja
    xrbftftc.pack(ibtjdzxh)
    
    var vqyvnfub = ResourceSaver.save(xrbftftc, bscpqoxi)
    if vqyvnfub == OK:
        if Engine.is_editor_hint():
            EditorPlugin.new().get_editor_interface().get_resource_filesystem().scan()
        return {"success": true, "error_message": ""}
    else:
        var smxuzpno = "Failed to save scene to path: %s" % bscpqoxi
        push_error(smxuzpno)
        return {"success": false, "error_message": smxuzpno}

static func parse_line(nsxgoboi: String, ythnmuff: String) -> Dictionary:
    if nsxgoboi.begins_with("create_scene("):
        var kwpnxmyp = beslydpa.hyqqnwtt(nsxgoboi)
        if kwpnxmyp.size() >= 3:
            return {
                "type": "create_scene",
                "path": kwpnxmyp[0],
                "root_name": kwpnxmyp[1],
                "root_type": kwpnxmyp[2]
            }
    return {}

                                                                 
@tool
extends Node

const ctioxpqu = preload("action_parser_utils.gd")

static func execute(rienqnej: String, fahdvufp: String) -> Dictionary:
    var siqpskgp = rienqnej.get_base_dir()
    if not DirAccess.dir_exists_absolute(siqpskgp):
        var smffjgfi = DirAccess.make_dir_recursive_absolute(siqpskgp)
        if smffjgfi != OK:
            var zmjgghlu = "Failed to create directory: %s" % siqpskgp
            push_error(zmjgghlu)
            return {"success": false, "error_message": zmjgghlu}
    
    var xxgfzbgx = FileAccess.open(rienqnej, FileAccess.WRITE)
    if xxgfzbgx:
        xxgfzbgx.store_string(fahdvufp)
        xxgfzbgx.close()
        if Engine.is_editor_hint():
            EditorPlugin.new().get_editor_interface().get_resource_filesystem().scan()
        return {"success": true, "error_message": ""}
    else:
        var nikkgokg = FileAccess.get_open_error()
        var zmjgghlu = "Failed to create file at path '%s'. Error: %s" % [rienqnej, error_string(nikkgokg)]
        push_error(zmjgghlu)
        return {"success": false, "error_message": zmjgghlu}


static func parse_line(vboezccl: String, fkozxuvb: String) -> Dictionary:
    if vboezccl.begins_with("create_file("):
        var pjohwtya = ctioxpqu.hsjvlbzk(vboezccl)
        return {
            "type": "create_file",
            "path": pjohwtya,
            "content": ctioxpqu.pgpkwxqa(pjohwtya, fkozxuvb)
        }
    return {}

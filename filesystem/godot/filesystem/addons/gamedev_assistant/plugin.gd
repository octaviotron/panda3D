            
@tool
extends EditorPlugin

var eskngrkd
var yirmjxow = preload("res://addons/gamedev_assistant/scripts/code_editor/CodeContextMenuPlugin.gd")
var ujztdqab:EditorContextMenuPlugin

func _enter_tree():
                                           
    eskngrkd = preload("res://addons/gamedev_assistant/dock/gamedev_assistant_dock.tscn").instantiate()
    add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_UL, eskngrkd)
    
                              
    ujztdqab = yirmjxow.new(eskngrkd)        
    add_context_menu_plugin(EditorContextMenuPlugin.CONTEXT_SLOT_SCRIPT_EDITOR_CODE,ujztdqab)

func _exit_tree():
                                
    remove_control_from_docks(eskngrkd)
    eskngrkd.queue_free()
    
    remove_context_menu_plugin(ujztdqab)

extends Node3D

var FS=Config.FSclass

var dirs = MKMesh.crear("directory")
var DirNode=Node3D
var DirLabel=Label3D

var files = MKMesh.crear("file")
var FileNode=Node3D
var FileLabel=Label3D

func _ready() -> void:
	DirNode = get_node("Frente/Directorios")
	DirLabel= get_node("Frente/Directorios/DirLabel")
	FileNode = get_node("Frente/Files")
	FileLabel= get_node("Frente/Files/FileLabel")
	putmesh()
	

func putmesh():
	var totales = fstotal()
	
	var dirtext = str(totales['directorios']["resumen"]['cantidad'])
	DirNode.add_child(dirs)
	DirLabel.text=dirtext
	
	var filetext = str(totales['archivos']["resumen"]['cantidad'])
	FileNode.add_child(files)
	FileLabel.text=filetext
	

func fstotal():
	var path = Config.currentpath
	var err= FS.leefs(path)
	if err:
		push_error(err)
		return false
	else:
		return (FS.resultados())




func _input(event):
	if event is InputEventKey:
		if event.pressed and (event.keycode == KEY_DOWN):
			volver_a_intro()


func volver_a_intro():
	pass
	#print("Volviendo a INTRO")
	# Cargar la escena main.tscn usando la ruta completa
	#var siguiente_escena = load(Config.escenas['intro'])
	#if siguiente_escena:
	#	get_tree().change_scene_to_packed(siguiente_escena)
	#else:
	#	push_error("No se pudo cargar la escena: res://escenas/main/main.tscn")

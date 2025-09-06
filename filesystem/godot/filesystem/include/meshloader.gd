class_name MKMesh
extends Node

static var _mesh_cache := {}

func _ready() -> void:
	preload_models(["casa", "directory", "img", "txt", "file"])

static func preload_models(model_names: Array[String]) -> void:
	for model_name in model_names:
		var mesh_path := "res://include/modelos/%s.tres" % model_name
		_mesh_cache[model_name] = load(mesh_path)

static func crear( model_name: String, node_name: String = "Model3D" ) -> Node3D:

	var mesh: Mesh
	if _mesh_cache.has(model_name):
		mesh = _mesh_cache[model_name]
	else:
		var mesh_path := "res://assets/modelos/%s.tres" % model_name
		mesh = load(mesh_path)
		if mesh:
			_mesh_cache[model_name] = mesh  # Almacenar en caché si la carga fue exitosa
			print("se añadió manualmente el modelo ", model_name)
	
	var model_node := Node3D.new()
	model_node.name = node_name
	var mesh_instance := MeshInstance3D.new()
	mesh_instance.name = node_name
	mesh_instance.mesh = mesh
	
	if model_name == "txt":	mesh_instance.rotation_degrees = Vector3(180, 0, 0)
	if model_name == "casa":
		mesh_instance.rotation_degrees = Vector3(0, 180, 0)
		mesh_instance.scale = Vector3(0.55, 0.22, 0.28)
	if model_name == "directory":	
		model_node.rotation_degrees = Vector3(0, 90, 0)
		mesh_instance.scale = Vector3(1.55, 1.55, 1.55)
	
	model_node.add_child(mesh_instance)
	mesh_instance.owner = model_node
	
	return model_node

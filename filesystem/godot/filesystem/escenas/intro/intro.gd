extends Node3D

func _ready() -> void:
	print(" ######### INTRO ", get_tree().current_scene.scene_file_path)
	
func _input(event):
	# Detectar la tecla Enter o Return
	if event is InputEventKey:
		if event.pressed and (event.keycode == KEY_SPACE):
			cambiar_a_escena_principal()

func cambiar_a_escena_principal():
	print("Cambiando a Escena Principal")
	# Cargar la escena main.tscn usando la ruta completa
	var siguiente_escena = load(Config.escenas['main'])
	if siguiente_escena:
		get_tree().change_scene_to_packed(siguiente_escena)
	else:
		push_error("No se pudo cargar la escena: res://escenas/main/main.tscn")

# res://escenas/main/camera_3d.gd
extends Camera3D

@export var velocidad : float = 6.0

const ALLOWED_ANGLES = [-90.0, 0.0, 90.0] # grados
var target_index : int = 1 # índice en ALLOWED_ANGLES (0:-90,1:0,2:90)
var girando : bool = false

func _ready() -> void:
	# Inicializa el índice objetivo al ángulo permitido más cercano a la rotación actual
	var current_deg : float = rad_to_deg(rotation.y)
	var best_idx := 0
	var best_diff = abs(current_deg - ALLOWED_ANGLES[0])
	for i in range(ALLOWED_ANGLES.size()):
		var d = abs(current_deg - ALLOWED_ANGLES[i])
		if d < best_diff:
			best_diff = d
			best_idx = i
	target_index = best_idx
	# Asegura que la rotación esté exactamente en un ángulo permitido
	rotation.y = deg_to_rad(ALLOWED_ANGLES[target_index])

func _input(event: InputEvent) -> void:
	# Soporta las acciones "ui_left"/"ui_right" y "rotate_left"/"rotate_right"
	if event.is_action_pressed("ui_left"):
		# Girar hacia la izquierda (más negativo), si no estamos ya en -90
		if target_index > 0:
			target_index -= 1
			girando = true
	elif event.is_action_pressed("ui_right"):
		# Girar hacia la derecha (más positivo), si no estamos ya en 90
		if target_index < ALLOWED_ANGLES.size() - 1:
			target_index += 1
			girando = true
	elif event.is_action_pressed("ui_up"):
		# Opcional: centrar a 0 grados
		if target_index != 1:
			target_index = 1
			girando = true

func _process(delta: float) -> void:
	if girando:
		var target_rad : float = deg_to_rad(ALLOWED_ANGLES[target_index])
		rotation.y = lerp_angle(rotation.y, target_rad, velocidad * delta)
		# Si estamos lo suficientemente cerca, fija y detén la interpolación
		if abs(rotation.y - target_rad) < 0.01:
			rotation.y = target_rad
			girando = false

extends Camera3D

@export var velocidad : float = 6.0 
var target_y : float = 0.0               # rotación deseada (radianes)
var girando  : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_y = rotation.y 
	pass # Replace with function body.


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_left"):          # flecha derecha
		target_y = deg_to_rad(90.0)               # 90 grados más
		girando = true
	if event.is_action_pressed("ui_up"):          # flecha derecha 
		target_y = deg_to_rad(0.0)               # 90 grados más
		girando = true
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if girando:
		# interpola hacia la rotación objetivo
		rotation.y = lerp_angle(rotation.y, target_y, velocidad * delta)
		
		# cuando esté lo bastante cerca, fija el valor y para
		if abs(rotation.y - target_y) < 0.01:
			rotation.y = target_y
			girando = false
	pass

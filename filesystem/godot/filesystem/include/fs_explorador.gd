# FSExplorador.gd
# Godot 4.4 – pure built-ins, no plug-ins
class_name FSExplorador
extends RefCounted

# -------------- internal state --------------
var fsruta := ""
var salida : Array = []

# -------------- helpers --------------
static func _size_to_bytes(size_str : String) -> int:
	if size_str.is_empty():
		return 0
	size_str = size_str.strip_edges().to_upper()
	var multi = { "K": 1024, "M": 1024 * 1024, "G": 1024 * 1024 * 1024, "T": 1024 * 1024 * 1024 * 1024 }
	for suffix in multi.keys():
		if size_str.ends_with(suffix):
			var num := size_str.trim_suffix(suffix)
			return int(float(num) * float(multi[suffix]))
	return int(float(size_str))

static func _bytes_to_human(b : int) -> String:
	for unit in ["B", "K", "M", "G"]:
		if b < 1024.0:
			var txt := "%.1f %s" % [b, unit]
			return txt.trim_suffix(".0")
		@warning_ignore("narrowing_conversion")
		b /= 1024.0
	var salid := "%.1f T" % b
	return salid.trim_suffix(".0")

# -------------- lectura --------------
func leefs(ruta : String) -> String:
	fsruta = ruta
	if not DirAccess.dir_exists_absolute(ruta):
		var msg := "Error: la ruta '%s' no existe o no es accesible." % ruta
		salida = [{ "error": msg }]
		return msg

	# Build tree command exactly like the Python version
	#var cmd := "tree -L 1 -J -a -p -u -g -h -D --dirsfirst \"%s\"" % ruta
	var output := []
	var exit_code := OS.execute("tree", ["-L","1","-J","-a","-p","-u","-g","-h","-D","--dirsfirst",ruta], output, true)
	var txt := "".join(output)  # merge stdout lines

	if exit_code != 0:
		var msg := "Error ejecutando 'tree': %s" % txt
		salida = [{ "error": msg }]
		return msg

	var json_result : Array = JSON.parse_string(txt)
	if json_result == null:
		var msg := "La salida de 'tree' no es JSON válido."
		salida = [{ "error": msg }]
		return msg

	salida = json_result
	return ""

# -------------- filtros --------------
func _elementos_directos(tipo : String, incluir_ocultos : bool = false, ordenar_por : String = "name") -> Array[Dictionary]:
	if salida.is_empty() or not salida[0].has("contents"):
		return []

	var elementos: Array[Dictionary] = []
	for it in salida[0]["contents"]:
		if it.get("type", "") == tipo:
			elementos.append(it)
			
	if not incluir_ocultos:
		elementos = elementos.filter(
			func(it): return not str(it.get("name", "")).begins_with(".")
		)

	if ordenar_por.is_empty():
		ordenar_por = "name"

	elementos.sort_custom(
		func(a, b):
			if ordenar_por == "size":
				var sa := str(a.get("size", ""))
				var sb := str(b.get("size", ""))
				return _size_to_bytes(sa) < _size_to_bytes(sb)
			return str(a.get(ordenar_por, "")) < str(b.get(ordenar_por, ""))
	)
	return elementos



# -------------- totales --------------

func resultados(incluir_ocultos : bool = false, ordenar_por : String = "name"):
	var dirs=_elementos_directos("directory", incluir_ocultos,ordenar_por)
	var files=_elementos_directos("file", incluir_ocultos,ordenar_por)
	var links=_elementos_directos("link", incluir_ocultos,ordenar_por)
	
	var total_bytes := 0
	for f in files:
		total_bytes += _size_to_bytes(str(f.get("size", "")))
	
	var result = {
		"directorios": { "resumen": { "cantidad": dirs.size(), "bytes": 0, "humano": "0 B"}, "elementos":dirs },
		"archivos":    { "resumen": { "cantidad": files.size(),   "bytes": total_bytes, "humano": _bytes_to_human(total_bytes) }, "elementos":files },
		"vinculos":    { "resumen": { "cantidad": links.size(),   "bytes": 0, "humano": "0 B"}, "elementos":links }
		}
	
	return result

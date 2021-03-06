# -*- coding: utf-8 -*-

# modified from https://github.com/wixette/font-to-3d-models

# USAGE:  blender -b -P blender.py


import sys, os, bpy

def MkModels(fontname):

	font_extrude = 0.05
	font_bevel = 0.03
	model_color = (1,1,1,1)
	characters = ['!', '"', '#', '$', '%', '&', "'", '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~', '¡', '¢', '£', '¤', '¥', '¦', '§', '¨', '©', 'ª', '«', '¬', '®', '¯', '°', '±', '²', '³', '´', 'µ', '¶', '·', '¸', '¹', 'º', '»', '¼', '½', '¾', '¿', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', '×', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ']

	pathvars = Init(fontname)
	for c in characters:
		print(" ----------------> MODELING", c, "(", str(ord(c)), ")")
		charname = create_model(c, pathvars["fontdata"], font_extrude, font_bevel, model_color)
		mkblender(charname, pathvars["blendpath"])
		mkglb(charname, pathvars["glbpath"])

def Init(fontname):
	salida = {}

	currentdir = os.path.dirname(__file__)
	outpath = os.path.join(currentdir,"fonts", fontname)
	if not os.path.isdir(outpath):
		print("ERROR: unable to read PATH", outpath)
		sys.exit()
	salida["outpath"] = outpath

	fontfile = os.path.join(outpath, "font.ttf")
	if not os.path.isfile(fontfile):
		print("ERROR: unable to read font.ttf", "from", outpath)
		sys.exit()

	existed_num = len(bpy.data.fonts)
	bpy.ops.font.open(filepath=fontfile)
	if not len(bpy.data.fonts) > existed_num:	
		print(f'ERROR: Failed to load the font {fontfile}')
		sys.exit()
	fontdata = bpy.data.fonts[-1].name
	salida["fontdata"] = fontdata

	glbpath = os.path.join(outpath, "glb")
	salida["glbpath"] = glbpath
	if not os.path.isdir(glbpath):	os.mkdir(glbpath)
	else:
		pass
		# Delete previous

	blendpath = os.path.join(outpath, "blender")
	salida["blendpath"] = blendpath
	if not os.path.isdir(blendpath): os.mkdir(blendpath)
	else:
		pass
		# Delete previous
	
	return salida
	

def create_model(character, font_data, font_extrude, font_bevel, model_color):
	# Delete all old fonts and meshes (cube)
	for obj in bpy.data.objects:
		if obj.type == 'FONT' or obj.type=="MESH":
			obj.select_set(True)
			bpy.ops.object.delete()

	charname = str(ord(character))

	# Adds a new text object.
	bpy.ops.object.text_add()
	text_obj = bpy.data.objects['Text']
	text_obj.name = charname
	text_obj.data.name = charname
	text_obj.data.body = character
	text_obj.data.size = 2
	text_obj.data.font = bpy.data.fonts[font_data]
	text_obj.data.extrude = font_extrude
	text_obj.data.bevel_depth = font_bevel
	text_obj.data.bevel_resolution = 3
	text_obj.select_set(True)

	# Center
	#bpy.ops.object.origin_set(type='ORIGIN_CENTER_OF_VOLUME', center='MEDIAN')

	text_obj.location.x = 0
	text_obj.location.y = 0
	text_obj.location.z = 0

	# Convert into mesh and add material and color data
	bpy.ops.object.convert(target='MESH')
	ob = bpy.context.active_object
	ob.select_set(True)
	mat = bpy.data.materials.get("Material")
	principled = mat.node_tree.nodes['Principled BSDF']
	mat.use_nodes = True
	principled.inputs['Base Color'].default_value = model_color
	ob.data.materials.append(mat)
	ob.select_set(True)

	# Unwrap UV map
	bpy.ops.object.mode_set(mode = 'EDIT') 
	bpy.ops.mesh.select_mode(type="VERT")
	bpy.ops.mesh.select_all(action = 'SELECT')
	bpy.ops.uv.unwrap()

	# Select Result MESH
	bpy.ops.object.mode_set(mode = 'OBJECT')
	for obj in bpy.data.objects:
		if obj.type=="MESH":
			obj.select_set(True)

	return charname



def mkblender(charname, outdir):
	blend_file = charname+'.blend'
	blend_path = os.path.join(outdir, blend_file)

	os.system('rm -f '+blend_path)
	bpy.ops.wm.save_mainfile(filepath=blend_path,check_existing = False)
	# remove buggy .blend1 copy
	blend1_file = charname+'.blend1'
	blend1_path = os.path.join(outdir, blend1_file)
	os.system('rm -f '+blend1_path)



def mkglb(charname, outdir):
	glb_file = charname+".glb"
	glb_path = os.path.join(outdir, glb_file)
	os.system('rm -f '+glb_path)
	bpy.ops.export_scene.gltf(filepath=glb_path, check_existing=False, export_format='GLB', export_copyright='CC-BY-NC', export_tangents=True, use_selection=True)


MkModels("DejaVuSansMono")


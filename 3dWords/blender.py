# -*- coding: utf-8 -*-

# modified from https://github.com/wixette/font-to-3d-models

import sys, os, bpy

outout_dir = "./fonts/"
formats = ["blend", "glb", "dae", "egg", "bam"]
#ttf_file = "fonts/font.ttf"
font_data = False
char_spacing = 1.2
font_extrude = .06
font_bevel = 0.05
model_color = (0,0,1,1)
letters = ['!', '"', '#', '$', '%', '&', "'", '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\\', ']', '^', '_', '`', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~', '¡', '¢', '£', '¤', '¥', '¦', '§', '¨', '©', 'ª', '«', '¬', '®', '¯', '°', '±', '²', '³', '´', 'µ', '¶', '·', '¸', '¹', 'º', '»', '¼', '½', '¾', '¿', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï', 'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', '×', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß', 'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï', 'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ']

def create_model(character):
	global outout_dir, font_data, char_spacing, font_extrude, font_bevel, model_color

	# Delete all old fonts and meshes (cube)
	for obj in bpy.data.objects:
		if obj.type == 'FONT' or obj.type=="MESH":
			obj.select_set(True)
			bpy.ops.object.delete()

	word = str(ord(character))

	# Adds a new text object.
	bpy.ops.object.text_add()
	text_obj = bpy.data.objects['Text']
	text_obj.name = "texto"
	text_obj.data.name = "texto"
	text_obj.data.body = character
	text_obj.data.size = 2
	text_obj.data.space_character = char_spacing
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


	return

def mkblender(character):
	global outout_dir
	blend_file = str(ord(character))+'.blend'
	blend_dir = outout_dir+"blender/"
	if (not os.path.isdir(blend_dir)):
		os.system('mkdir -p '+blend_dir)
	blend_path = os.path.join(blend_dir, blend_file)
	os.system('rm -f '+blend_path)
	bpy.ops.wm.save_mainfile(filepath=blend_path,check_existing = False)
	# remove buggy .blend1 copy
	blend1_file = str(ord(character))+'.blend1'
	blend1_path = os.path.join(blend_dir, blend1_file)
	os.system('rm -f '+blend1_path)

def mkdae(character):
	global outout_dir
	dae_file = str(ord(character))+'.dae'
	dae_dir = outout_dir+"dae/"
	if (not os.path.isdir(dae_dir)):
		os.system('mkdir -p '+dae_dir)
	dae_path = os.path.join(dae_dir, dae_file)
	os.system('rm -f '+dae_path)
	bpy.ops.wm.collada_export(filepath=dae_path, check_existing=False, apply_modifiers=True, selected=True, include_children=True)
	print("DAE:", dae_path)

def mkglb(character):
	global outout_dir
	glb_file = str(ord(character))+".glb"
	glb_dir = outout_dir+"glb/"
	if (not os.path.isdir(glb_dir)):
		os.system('mkdir -p '+glb_dir)
	glb_path = os.path.join(glb_dir, glb_file)
	os.system('rm -f '+glb_path)
	bpy.ops.export_scene.gltf(filepath=glb_path, check_existing=False, export_format='GLB', export_copyright='CC-BY-NC', export_tangents=True, use_selection=True)
	print("GLB", glb_path)
	

def load_font():
	global font_data
	font_file = "font.ttf"
	font_dir = "./fonts"
	font_path = os.path.join(font_dir, font_file)
	existed_num = len(bpy.data.fonts)
	bpy.ops.font.open(filepath=font_path)
	if len(bpy.data.fonts) > existed_num:
		font_data = bpy.data.fonts[-1].name
	else:
		print(f'Failed to load the font {font_path}')
		sys.exit()



def main(letters):
	print('blender -b -P blender.py"')

	load_font()

	for l in letters:
		print("---------------------  MODELING", l, "---------------------")
		create_model(l)
		mkblender(l)
		#mkdae(l)
		mkglb(l)

main(letters)


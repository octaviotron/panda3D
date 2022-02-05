# -*- coding: utf-8 -*-

# modified from https://github.com/wixette/font-to-3d-models

import os
import sys
import bpy

char_spacing = 1.2
font_extrude = .06
font_bevel = 0.05
model_color = (0,0,1,1)

def create_model(word, font_name, outout_dir):
	global char_spacing, font_extrude, font_bevel, model_color

	# Delete all old fonts and meshes (cube)
	for obj in bpy.data.objects:
		if obj.type == 'FONT' or obj.type=="MESH":
			obj.select_set(True)
			bpy.ops.object.delete()

	# Adds a new text object.
	bpy.ops.object.text_add()
	text_obj = bpy.data.objects['Text']
	text_obj.name = word
	text_obj.data.name = word
	text_obj.data.body = word
	text_obj.data.size = 2
	text_obj.data.space_character = char_spacing
	text_obj.data.font = bpy.data.fonts[font_name]
	text_obj.data.extrude = font_extrude
	text_obj.data.bevel_depth = font_bevel
	text_obj.data.bevel_resolution = 3
	text_obj.select_set(True)

	# Center
	bpy.ops.object.origin_set(type='ORIGIN_CENTER_OF_VOLUME', center='MEDIAN')
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

	dae_file = 'word.dae'
	dae_path = os.path.join(outout_dir, dae_file)
	os.system('rm -f '+dae_path)
	bpy.ops.wm.collada_export(filepath=dae_path, check_existing=False, apply_modifiers=True, selected=True, include_children=True)

	egg_file = "word.egg"
	egg_path = os.path.join(outout_dir, egg_file)
	os.system('rm -f '+egg_path)
	os.system('dae2egg '+dae_path+' '+egg_path)
	os.system('rm -f '+dae_path)

	bam_file = "word.bam"
	bam_path = os.path.join(outout_dir, bam_file)	
	os.system('rm -f '+bam_path)
	os.system('egg2bam '+egg_path+' '+bam_path)
	os.system('rm -f '+egg_path)
	

def load_font(font_path):
	existed_num = len(bpy.data.fonts)
	bpy.ops.font.open(filepath=font_path)
	if len(bpy.data.fonts) > existed_num:
		font_name = bpy.data.fonts[-1].name
		return font_name
	else:
		print(f'Failed to load the font {font_path}')
		return None

def main(argv):
	if (len(argv) < 2):
		print('Usage: ')
		print('blender -b -P 3dWords.py -- "<word>"')

	font_path = os.path.abspath("font.ttf")
	if (not os.path.isfile(font_path)):
		print('Font file %s does not exist.' % font_path)
		return

	output_dir = os.path.abspath("./out")
	if (not os.path.isdir(output_dir)):
		print(f'Output dir {output_dir} does not exist.')
		return

	font_name = load_font(font_path)

	# Generates model.
	word = str(argv[0])
	create_model(word, font_name, output_dir)


if __name__ == '__main__':
	# Filters out Blender arguments.
	for i, arg in enumerate(sys.argv):
		if arg == '--':
			break
	main(sys.argv[i+1:])

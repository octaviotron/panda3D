extends Node

var escenas={
		"intro":"res://escenas/intro/intro.tscn",
		"main":"res://escenas/main/main.tscn"
		}

const FSpreload:= preload("res://include/fs_explorador.gd")
var FSclass = FSpreload.new()

var currentpath := OS.get_environment("HOME")

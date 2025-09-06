#!/usr/bin/env python3
import sys
import os
from libs.FS import FSExplorador

# Se crea el explorador una sola vez
explorador = FSExplorador()

# -- primera ruta --
explorador.leefs("/home/tr0n")
print("---------------------")
print("Archivos:", explorador.archivos(incluir_ocultos=True, ordenar_por="size"))
print("---------------------")
print("Totales:", explorador.totales())
print("---------------------")
print("###############################")
print("###############################")
print("---------------------")
print("Archivos:", explorador.archivos(incluir_ocultos=False, ordenar_por="size"))
print("---------------------")
print("Totales:", explorador.totales())
print("---------------------")
# -- cambiamos de ruta --
#explorador.leefs("/home/tr0n/tmp")
#print("Archivos:", explorador.archivos(incluir_ocultos=True, ordenar_por="size"))
#print("---------------------")
#print("Totales:", explorador.totales())


# AlfaBetoCeta

AlfaBetoCeta es un desarrollo realizado con el motor de juegos Panda3D y sus modelos están diseñados con Blender.

Estudiando estos programas me propuse hacer algo funcional y tomé como objetivo construir algo para facilitar el aprendizaje de mi hija. Actualmente las actividades son "Letras" (conocer el alfabeto e identificar mayúsculas y minúsculas), "Numeros" (aprender operaciones matemáticas elementales: suma y resta), "Geometría" (identificación de formas geométricas básicas) y "Teclas" (aprender la ubicación de las letras en un teclado).

Un profesional de la programación en Python notará que algunas piezas de código pueden mejorar en sus declaraciones y algoritmos (por ejemplo reemplazando el uso de variables globales o cambiando el funcionamiento de los intérvalos) pero es un desarrollo que hice para aprender la lógica del modelado y los componentes fundamentales de la programación 3D con Software Libre.

La licencia es GPLv3, por tanto eres libre de descargar el código fuente, estudiarlo, modificarlo (si lo haces agradecería mucho que me compartieras tus mejoras), ejecutar los binarios compilados, usarlo para la educación de niños o programadores y publicar tus propias versiones, siempre y cuando mantengas la licencia.

NOTA: el archivo sound/Mia.ogg es una composición musical propia que grabé hace tiempo (aprox. 2002) y se la dediqué ahora a mi hija, por eso lleva su nombre. Tiene licencia CC-BY-SA-NC.

**Pendiente por Corregir:**

- En algunas tareas, al elegir una respuesta aparece por un corto instante un buffer con la última animación del logro. Es necesario reescribir la lógica de creación, referenciado, llamado, ejecucuión y limpieza de este evento.
- La posición de la zona de selección para las letras en las actividades "Mayúsculas" y "Minúsculas" están movidas hacia abajo.
- Los audios tanto de las voces deben ser tomados de personas con habilidades para la dicción. Actualmente la voz femenina es una síntesis automatizada y la masculina requiere normalizar los volúmenes y mejorar la pronunciación.

## Cómo ejecutar AlfaBetoCeta

Al descargar el repo, se ejecuta el archivo "index.py" desde un intérprete de Python 3 con las librerías previemente instaladas de Panda3d.

He publicado en la sección "Releases" de este repo (https://github.com/octaviotron/panda3D/releases) también los binarios precompilados para GNU/Linux y Windows (ambos sólo para 64bits).

Desarrollado por Octavio Rossell Tabet <octavio.rossell@gmail.com>


#!/usr/bin/env python3
"""Recorta el borde negro de la ventana de GTKWave y el espacio vacío
inferior de las capturas de ondas del reporte datapath-1.

GTKWave (v3.3.116) vuelca con /File/Grab_To_File la ventana completa,
incluido el marco negro del gestor en esta sesión WSLg. Este script:

  1. recorta al rectángulo no negro (elimina el marco),
  2. recorta la altura al último renglón con actividad en el panel de
     ondas (elimina el espacio en blanco sobrante),
  3. deja un margen blanco uniforme.

Uso:  python3 reportes/datapath-1/capturas/recortar.py <png_entrada>
"""
import sys

from PIL import Image


def recortar(ruta):
    im = Image.open(ruta).convert("RGB")
    ancho, alto = im.size
    px = im.load()

    def negro(c):
        return c[0] < 60 and c[1] < 60 and c[2] < 60

    # 1) bbox de píxeles no negros = contenido útil (quita el marco)
    minx, miny, maxx, maxy = ancho, alto, 0, 0
    for y in range(alto):
        for x in range(ancho):
            if not negro(px[x, y]):
                minx = min(minx, x)
                maxx = max(maxx, x)
                miny = min(miny, y)
                maxy = max(maxy, y)

    # 2) dentro del contenido, buscar el último renglón con onda activa
    #    en el panel derecho (x >= 200) para quitar el vacío inferior
    ancho_cont = maxx - minx + 1
    x0 = minx + int(ancho_cont * 0.4)
    def fila_con_onda(y):
        return sum(1 for x in range(x0, maxx + 1) if sum(px[x, y]) < 250) > 4

    ultimo = maxy
    for y in range(maxy, miny, -1):
        if fila_con_onda(y):
            ultimo = y
            break
    # 2b) excluir filas "activas" aisladas abajo (thrash de una sola columna):
    _, active = [], []
    for y in range(miny, ultimo + 1):
        if fila_con_onda(y):
            active.append(y)
    if active:
        # último grupo contiguo de filas activas (tolerancia 3 px)
        fin = active[-1]
        for y in range(ultimo, miny, -1):
            consec = [a for a in active if abs(a - y) <= 3]
            if len(consec) >= 4:
                fin = max(consec)
                break
        ultimo = fin

    # 3) recorte al contenido + margen blanco uniforme
    contenido = im.crop((minx, miny, maxx + 1, ultimo + 1))
    margen = 6
    cw = contenido.size[0] + 2 * margen
    ch = contenido.size[1] + 2 * margen
    salida = Image.new("RGB", (cw, ch), (255, 255, 255))
    salida.paste(contenido, (margen, margen))
    salida.save(ruta)
    print(f"{ruta}: {ancho}x{alto} -> {salida.size[0]}x{salida.size[1]}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        sys.exit("uso: recortar.py <png_entrada>")
    recortar(sys.argv[1])

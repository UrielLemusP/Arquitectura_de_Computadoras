# Guía Git — Flujo de trabajo del equipo

Flujo **Git Flow ligero** sobre la rama `dev` (no se renombra). 5 integrantes,
4 unidades de trabajo. Objetivo: que nadie se pise.

---

## Ramas

```
main ───────────── entregas finales (solo PRs desde dev + tags; NUNCA push directo)
  ▲
dev ────────────── rama base de integración (aquí vive el trabajo del equipo)
  ▲
 ├── reporte/datapath-1      ├── vhdl/datapath-1
 ├── reporte/datapath-2      ├── vhdl/datapath-2
 ├── reporte/datapath-3      ├── vhdl/datapath-3
 └── reporte/mapeo-memoria   └── vhdl/mapeo-memoria
```

- `reporte/<unidad>` — se escribe LaTeX del reporte de esa unidad.
- `vhdl/<unidad>` — se escribe/deepura el VHDL de esa unidad.
- Las unidades: `datapath-1`, `datapath-2`, `datapath-3`, `mapeo-memoria`.

**Reglas duras:**

1. **Nunca** `git push` directo a `main`.
2. **Nunca** `--force` en `dev` ni en ramas compartidas.
3. `git pull` antes de empezar cada jornada y antes de hacer push.
4. Todo cambio pasa por **Pull Request** hacia `dev`.
5. Trabaja en **una rama a la vez**; termina (PR fusionado) antes de abrir otra.

## Primer contacto (una sola vez)

```bash
git clone git@github.com:cuter177/Arquitectura_de_Computadoras.git
cd Arquitectura_de_Computadoras
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
git config --global core.autocrlf input    # importante en WSL/Windows
git switch dev
```

En Windows/WSL ver `docs/guia-wsl.md` (claves SSH, ubicación del clon).

## Flujo diario

```bash
# 1. Empezar: traer lo último y crear tu rama
git switch dev
git pull
git switch -c reporte/datapath-1          # o vhdl/datapath-1, etc.

# 2. Trabajar (con OpenCode o a mano): cambios pequeños y frecuentes
git status
git add reportes/datapath-1/main.tex
git commit -m "reporte(datapath-1): añadir sección de diseño teórico"

# 3. Subir tu rama
git push -u origin reporte/datapath-1

# 4. Abrir PR hacia dev en GitHub y pedir revisión
```

### Si alguien ya fusionó cambios en `dev` mientras trabajabas

```bash
git switch dev
git pull
git switch reporte/datapath-1
git merge dev            # si hay conflictos, ver abajo
```

### Terminar una unidad

1. PR de `reporte/<unidad>` → `dev`, revisión, merge.
2. Borrar la rama fusionada: `git branch -d reporte/datapath-1` y
   `git push origin --delete reporte/datapath-1`.
3. Cuando **todas** las unidades de un entregable estén en `dev` y compilando:
   PR `dev` → `main` + etiqueta:

```bash
git switch dev && git pull
git switch -c entrega/datapath-1-entrega
# ... merge a main vía PR ...
git tag v-datapath-1
git push origin v-datapath-1
```

## Convención de commits (Conventional Commits, en español)

```
<tipo>(<alcance>): <descripción en imperativo>

tipo:    reporte | vhdl | docs | scripts | repo
alcance: datapath-1 | datapath-2 | datapath-3 | mapeo-memoria | comun | general
```

Ejemplos:

```
reporte(datapath-1): añadir sección de resultados con tabla de tiempos
vhdl(datapath-2): testbench del acumulador con autochequeo
docs: añadir guía WSL para el equipo Windows
scripts: instalar.sh detecta WSL y comprueba GUI de GTKWave
repo: añadir .gitattributes para forzar LF
```

- Mensajes en **español**, cuerpo opcional explicando el *por qué*.
- **Un commit = una idea**. No mezcles un VHDL nuevo con 3 cambios de LaTeX.
- Nunca subas artefactos (`.gitignore` ya los cubre; si ves uno en `git status`,
  no lo agregues).

## Resolver conflictos

```bash
git merge vhdl/datapath-1        # o al hacer pull de dev
# git status                     # ver los ficheros con "both modified"
# editar cada fichero: quitar los <<<<<<< ======= >>>>>>>
git add <fichero-resuelto>
git commit                       # completa la fusión
```

- Casi todos los conflictos se evitan porque **cada unidad tiene su carpeta**:
  `reportes/datapath-1/` y `vhdl/datapath-1/` no los toca nadie más.
- Conflictos en `AGENTS.md`, `docs/`, `scripts/` = pocos cambios y coordinados;
  habla en el equipo antes de reescribirlos.

## Comandos de emergencia

```bash
git status                        # qué tengo cambiado
git log --oneline --graph -10     # historia reciente
git diff                          # mis cambios sin confirmar
git restore <fichero>             # deshacer cambios locales NO añadidos
git restore --staged <fichero>    # quitar del área de preparación
git reflog                        # "cinta negra": recupera commits perdidos
git stash                         # guardo cambios al margen
git stash pop                     # recupero los guardados
```

**No uses** `git reset --hard` ni `push --force` salvo que la IA/una persona
del equipo te lo indique explícitamente tras explicarte la consecuencia.

## Responsables (editar al repartir trabajo)

| Unidad | Rama reporte | Rama VHDL | Integrantes |
|---|---|---|---|
| datapath-1 | `reporte/datapath-1` | `vhdl/datapath-1` | _por rellenar_ |
| datapath-2 | `reporte/datapath-2` | `vhdl/datapath-2` | _por rellenar_ |
| datapath-3 | `reporte/datapath-3` | `vhdl/datapath-3` | _por rellenar_ |
| mapeo-memoria | `reporte/mapeo-memoria` | `vhdl/mapeo-memoria` | _por rellenar_ |

> Los 5 integrantes son autores de **todos** los reportes; la tabla reparte quién
> lidera cada unidad para evitar pisarse. Edítadla al empezar.

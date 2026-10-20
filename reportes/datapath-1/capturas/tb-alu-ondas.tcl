# ============================================================
# Captura de ondas de tb_alu (las 3 operaciones, límites y
# genérico ANCHO=4).
# Ejecutar DESDE LA RAÍZ DEL REPO:
#   gtkwave -r reportes/datapath-1/capturas/gtkwave.rc \
#           -S reportes/datapath-1/capturas/tb-alu-ondas.tcl \
#           vhdl/datapath-1/salidas/tb_alu.vcd
# Genera reportes/datapath-1/figuras/tb-alu-ondas.png
# Tras el volcado, recortar el marco negro y el hueco inferior con:
#   python3 reportes/datapath-1/capturas/recortar.py \
#           reportes/datapath-1/figuras/tb-alu-ondas.png
# ============================================================
# 1) Señales del banco de pruebas de la ALU
gtkwave::addSignalsFromList {
tb_alu.c[2:0]
tb_alu.a8[7:0]
tb_alu.b8[7:0]
tb_alu.f8[7:0]
tb_alu.a4[3:0]
tb_alu.b4[3:0]
tb_alu.f4[3:0]
}
# 2) Nombres a la izquierda (nombre || onda)
gtkwave::/View/Left_Justified_Signals
# 3) Fondo claro: paleta blanco y negro
gtkwave::/View/Use_Black_and_White
# 4) Datos en hexadecimal; código de operación en binario
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Data_Format/Hex
gtkwave::/Edit/UnHighlight_All
gtkwave::highlightSignalsFromList {tb_alu.c[2:0]}
gtkwave::/Edit/Data_Format/Binary
gtkwave::/Edit/UnHighlight_All
# 5) Eje de tiempos ajustado a toda la simulación
gtkwave::/Time/Zoom/Zoom_Best_Fit
# 6) Volcado a PNG
gtkwave::/File/Grab_To_File "reportes/datapath-1/figuras/tb-alu-ondas.png"
gtkwave::/File/Quit

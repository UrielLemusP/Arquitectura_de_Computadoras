# ============================================================
# Captura de ondas de tb_datapath (multi-ciclo con CW manual).
# Ejecutar DESDE LA RAÍZ DEL REPO:
#   gtkwave -r reportes/datapath-1/capturas/gtkwave.rc \
#           -S reportes/datapath-1/capturas/tb-datapath-ondas.tcl \
#           vhdl/datapath-1/salidas/tb_datapath.vcd
# Genera reportes/datapath-1/figuras/tb-datapath-ondas.png
# Tras el volcado, recortar el marco negro y el hueco inferior con:
#   python3 reportes/datapath-1/capturas/recortar.py \
#           reportes/datapath-1/figuras/tb-datapath-ondas.png
# ============================================================
# 1) Señales del datapath en el orden del esquema
gtkwave::addSignalsFromList {
tb_datapath.clk
tb_datapath.rst
tb_datapath.dato_ext[7:0]
tb_datapath.cw[5:0]
tb_datapath.f_alu[7:0]
tb_datapath.q_reg[7:0]
tb_datapath.salida[7:0]
}
# 2) Todos los signos a la izquierda (nombre || onda)
gtkwave::/View/Left_Justified_Signals
# 3) Fondo claro: paleta blanco y negro
gtkwave::/View/Use_Black_and_White
# 4) Formato: buses de datos en hexadecimal, palabra de control en binario
gtkwave::/Edit/Highlight_All
gtkwave::/Edit/Data_Format/Hex
gtkwave::/Edit/UnHighlight_All
gtkwave::highlightSignalsFromList {tb_datapath.cw[5:0]}
gtkwave::/Edit/Data_Format/Binary
gtkwave::/Edit/UnHighlight_All
# 5) Ajuste del eje de tiempos a toda la simulación
gtkwave::/Time/Zoom/Zoom_Best_Fit
# 6) Volcado a PNG (el borde negro de la ventana lo recorta
#    scripts en figuras/ mediante recorte posterior determinista)
gtkwave::/File/Grab_To_File "reportes/datapath-1/figuras/tb-datapath-ondas.png"
gtkwave::/File/Quit

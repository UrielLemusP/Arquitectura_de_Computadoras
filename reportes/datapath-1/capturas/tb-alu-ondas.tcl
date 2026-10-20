# ============================================================
# Captura de ondas de tb_alu (las 3 operaciones, límites y
# genérico ANCHO=4).
# Ejecutar DESDE LA RAÍZ DEL REPO:
#   gtkwave -S reportes/datapath-1/capturas/tb-alu-ondas.tcl \
#           vhdl/datapath-1/salidas/tb_alu.vcd
# Genera reportes/datapath-1/figuras/tb-alu-ondas.png
# (método heredado de reportes/datapath-3/capturas/*.tcl)
# ============================================================
gtkwave::addSignalsFromList {
tb_alu.c[2:0]
tb_alu.a8[7:0]
tb_alu.b8[7:0]
tb_alu.f8[7:0]
tb_alu.a4[3:0]
tb_alu.b4[3:0]
tb_alu.f4[3:0]
}
gtkwave::/View/Left_Justified_Signals
gtkwave::/View/Use_Black_and_White
gtkwave::/Time/Zoom/Zoom_Best_Fit
gtkwave::/File/Grab_To_File "reportes/datapath-1/figuras/tb-alu-ondas.png"
gtkwave::/File/Quit

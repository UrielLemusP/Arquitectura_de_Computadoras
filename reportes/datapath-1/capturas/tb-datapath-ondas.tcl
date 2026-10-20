# ============================================================
# Captura de ondas de tb_datapath (multi-ciclo con CW manual).
# Ejecutar DESDE LA RAÍZ DEL REPO:
#   gtkwave -S reportes/datapath-1/capturas/tb-datapath-ondas.tcl \
#           vhdl/datapath-1/salidas/tb_datapath.vcd
# Genera reportes/datapath-1/figuras/tb-datapath-ondas.png
# (método heredado de reportes/datapath-3/capturas/*.tcl)
# ============================================================
gtkwave::addSignalsFromList {
tb_datapath.clk
tb_datapath.rst
tb_datapath.dato_ext[7:0]
tb_datapath.cw[5:0]
tb_datapath.f_alu[7:0]
tb_datapath.q_reg[7:0]
tb_datapath.salida[7:0]
}
gtkwave::/View/Left_Justified_Signals
gtkwave::/View/Use_Black_and_White
gtkwave::/Time/Zoom/Zoom_Best_Fit
gtkwave::/File/Grab_To_File "reportes/datapath-1/figuras/tb-datapath-ondas.png"
gtkwave::/File/Quit

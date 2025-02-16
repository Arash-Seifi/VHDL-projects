
# Transcript on
transcript on

# Recreate work library
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

# Find out if we're started through Quartus or by hand
# (or by using an exec in the Tcl window in Quartus).
# Quartus has the annoying property that it will start
# Modelsim from a directory called "simulation/modelsim".
# The design and the testbench are located in the project
# root, so we've to compensate for that.

if [ string match "*simulation/modelsim" [pwd] ] { 
	set prefix "../../"
	puts "Running Modelsim from Quartus..."
} else {
	set prefix ""
	puts "Running Modelsim..."
}

# Compile the VHDL description and testbench,  
# please note that the design and its testbench are located
# in the project root, but the simulator start in directory
# <project_root>/simulation/modelsim, so we have to compensate
# for that.
vcom -93 -work work{prefix}lab3.vhd
vcom -93 -work work{prefix}pkg.vhd
vcom -93 -work work{prefix}tb_lab3.vhd

vsim -t -showsubprograms 1ns -L rtl_work -L work tb_lab3

# Log all signals in the design, good if the number
# of signals is small.
add log -r *

# Add all toplevel signals
# Add a number of signals of the simulated design

add wave conin 
add wave inbus
add wave ir
add wave condition



# Open Structure, Signals (waveform) and List window
view structure
#view list
view signals

# Run simulation for 4000 ns
run 2 ms

# Fill up the waveform in the window
wave zoom full
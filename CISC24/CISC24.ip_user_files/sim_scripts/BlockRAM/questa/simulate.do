onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib BlockRAM_opt

do {wave.do}

view wave
view structure
view signals

do {BlockRAM.udo}

run -all

quit -force

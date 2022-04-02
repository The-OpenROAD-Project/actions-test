
if { [info exist ::env(MAGIC_EXT_USE_GDS)] && $::env(MAGIC_EXT_USE_GDS) } {
	gds read $::env(CURRENT_GDS)
} else {
	lef read /home/runner/work/_temp/pdks/sky130A/libs.ref/sky130_fd_sc_hd/techlef/sky130_fd_sc_hd.tlef
	if {  [info exist ::env(EXTRA_LEFS)] } {
		set lefs_in $::env(EXTRA_LEFS)
		foreach lef_file $lefs_in {
			lef read $lef_file
		}
	}
	def read /openlane/designs/my_design/runs/openlane_test/results/routing/spm.def
}
load spm -dereference
cd /openlane/designs/my_design/runs/openlane_test/results/finishing/
extract do local
extract no capacitance
extract no coupling
extract no resistance
extract no adjust
if { ! 0 } {
	extract unique
}
# extract warn all
extract

ext2spice lvs
ext2spice -o /openlane/designs/my_design/runs/openlane_test/results/finishing/spm.spice spm.ext
feedback save /openlane/designs/my_design/runs/openlane_test/logs/finishing/29-ext2spice.feedback.txt
# exec cp spm.spice /openlane/designs/my_design/runs/openlane_test/results/finishing/spm.spice


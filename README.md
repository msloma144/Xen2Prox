# Xen2Prox

I am changing from Xenserver to Proxmox, and since there was no good way to go from an OVA/OVF
to a Proxmox machine, I implimented one.
Each VM from Xen was exprted indvidually to an OVA/OVF. The script then will enumerate the folders
containing these to import the .ovf files and .vhd files to build the machine. Sadly,
Proxmox will not import the network interfaces or attach the drive so this so far needs to be done
manually. If anyone knows how to automate this, please reach out to me!

## Usage
Export Xenserver VM's to folder:
	Exports/
			VM1/
			VM2/
			etc...
	xen2prox.sh
Then run xen2prox.sh inside the folder containing the OVA/OVF files.

## Authors

* **Michael Sloma**

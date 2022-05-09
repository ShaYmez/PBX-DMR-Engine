#!/bin/bash

# IPSC2 Only

if [[ $(/opt/MMDVM_Bridge/dvswitch.sh mode) = "DMR" ]];  then
	echo DMR Mode
	/opt/MMDVM_Bridge/dvswitch.sh tune 400
fi
if [[ $(/opt/MMDVM_Bridge/dvswitch.sh mode) = "YSFN" ]];  then
	echo YSF Mode
	/opt/MMDVM_Bridge/dvswitch.sh tune disconnect
fi
if [[ $(/opt/MMDVM_Bridge/dvswitch.sh mode) = "NXDN" ]];  then
	echo NXDN Mode
	/opt/MMDVM_Bridge/dvswitch.sh tune 9999
fi
if [[ $(/opt/MMDVM_Bridge/dvswitch.sh mode) = "P25" ]]; then
	echo P25 Mode
	/opt/MMDVM_Bridge/dvswitch.sh tune 9999
fi
if [[ $(/opt/MMDVM_Bridge/dvswitch.sh mode) = "DSTAR" ]]; then
	echo DSTAR Mode
	/opt/MMDVM_Bridge/dvswitch.sh tune U
fi
sleep 5

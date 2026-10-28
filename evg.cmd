#!/epics/base-7.0.9/modules/mrfioc2/bin/linux-x86_64/mrf

epicsEnvSet "mrfioc2_DIR" "$(mrfioc2_DIR=/epics/base-7.0.9/modules/mrfioc2)"

dbLoadDatabase /epics/base-7.0.9/modules/mrfioc2/dbd/mrf.dbd

mrf_registerRecordDeviceDriver(pdbbase)

epicsEnvSet "P" "TDL-ICS:Ctrl-EVG-992:"
epicsEnvSet "PCIID" "0b:00.0"

var evrMrmTimeNSOverflowThreshold 60000000

mrmEvgSetupPCI "$(EVG=EVM)" "$(PCIID=$(BUSNO=00):$(DEVNO=00).$(FUNCNO=0))"

dbLoadRecords "$(mrfioc2_DIR)/db/$(EVMDB=evm-mtca-300.uv.db)"     "P=$(P),EVG=$(EVG=EVM),FRF=352.209984,RFDIV=$(RFDIV=4),FEVT=88.052496"

dbLoadRecords "$(mrfioc2_DIR)/db/$(EVMDB=evm-mtca-300-evr.uv.db)"     "P=$(P)U-,EVG=$(EVG=EVM),T=U"
dbLoadRecords "$(mrfioc2_DIR)/db/$(EVMDB=evm-mtca-300-evr.uv.db)"     "P=$(P)D-,EVG=$(EVG=EVM),T=D"

iocInit

dbpf $(P)EvtClkSource-Sel 0
epicsThreadSleep 2
dbpf $(P)PpsInp-Sel 7
epicsThreadSleep 2
dbpf $(P)SyncTimestamp-Cmd 1

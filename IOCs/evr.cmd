#!/epics/base-7.0.9/modules/mrfioc2/bin/linux-x86_64/mrf

dbLoadDatabase /epics/base-7.0.9/modules/mrfioc2/dbd/mrf.dbd

mrf_registerRecordDeviceDriver(pdbbase)

epicsEnvSet "P" "TDL-ICS:Ctrl-EVR-994:"
epicsEnvSet "PCIID" "0e:00.0"

var evrMrmTimeNSOverflowThreshold 60000000

mrmEvrSetupPCI "$(EVR=EVR)" "$(PCIID=$(BUSNO=00):$(DEVNO=00).$(FUNCNO=0))"

#dbLoadRecords "db/evr-base.univ.db"              "P=$(P),EVR=$(EVR=EVR),FEVT=$(FEVT=88.0525)"
dbLoadRecords "/epics/base-7.0.9/modules/mrfioc2/db/evr-mtca-300u.uv.db" "P=$(P),EVR=$(EVR=EVR),FEVT=$(FEVT=88.0525)"

iocInit

dbpf "$(P)DCTgt-SP" "$(DlyComp=10000)"
dbpf "$(P)DCEna-Sel" "Enable"
dbpf "$(P)TimeSrc-Sel" "0"

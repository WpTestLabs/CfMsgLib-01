#!/bin/sh
#	echo "WkFloMainRcv.sh";

export LogFQPFN=/srv/log/wkFlo/hstWkFloRcvRAW.txt
# Example - msg () { echo "$@" >> $LogFQPFN; } # For Knz, add hardlink w/in Kn vw back to main fifo

echo "#### Start: $LogFQPFN ####"  > $LogFQPFN
log () { echo "`date +%Y/%m/%d-%T` - $@" >>$LogFQPFN; }
export -f log #@@@ But not in Alpine!!!
log "[Hst] Starting log for: fifoRcvLib.sh"

. $SrvLib/fifoRcvLib.sh # Here $SrvLib is HX

CmdMp[SqlHB]=SqlHB
CmdMp[TL]=TL
CmdMp[WkPrxySQL]=WkPrxySQL

SqlHB () { log "[SQL] SqlHB: $@  `cat /proc/uptime`"; }
TL () { echo "`cat /proc/uptime` -- $@" >> /TimeLine.txt; }

WkPrxySQL () {  log "[WkFlo] Start - WkPrxySQL()  xc: $1   FQHP: $2  FN: $3"
    if [[ "0" = $1 ]]; then
    	log "[WkFlo] WkPrxySQL() - Push $2$3 OffSite!"
    else
    	log "[WkFlo] WkPrxySQL() - Error exit code: $1"
    fi
}
#######

#qq mkdir -p /srv/run/wkFlo  $Srv/Knz/WkFlo/srv/cmd
#qq cd $Srv/Knz/WkFlo/srv/cmd
#qq startFifoRcv $Srv/Knz/WkFlo/srv/cmd /srv/run/wkFlo/hstWkFloRcv.fifo

suFifoRcv $Srv/Knz/WkFlo/srv/cmd /srv/run/wkFlo  hstWkFloRcv.fifo
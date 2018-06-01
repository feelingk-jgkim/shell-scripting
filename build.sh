#!/bin/sh

function usage {
    echo "Usage: $0 WAR NAME old-version new-version [options]"
    echo ""
    echo "options:"
    echo "   -z | --Zip      Generate zip file only"

    exit;
}

function LOG {
    echo --- $*
}

if [ $# -lt 4 ]; then
    echo "Lacking in arguments"
    usage;
fi;
#sleep 1;

WDIR=$PWD
WARF=$1
NAME=$2
OLDV=$3
NEWV=$4
ONLY_ZIP=false
case $5 in
    -z|--Zip|--zip|--ZIP)
        ONLY_ZIP=true
        ;;
    *)
        ONLY_ZIP=false
        ;;
esac;
LOG "WDIR: ${WDIR}"
LOG "WARF: ${WARF}"
LOG "NAME: ${NAME}"
LOG "OLDV: ${OLDV}"
LOG "NEWV: ${NEWV}"
LOG "ONLY_ZIP: ${ONLY_ZIP}"
sleep 1;

# prepare working directory
# unpacking war
# generate zip file

exit;
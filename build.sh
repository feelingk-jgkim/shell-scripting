#!/bin/sh

function usage {
    echo "Usage: $0 WAR NAME old-version new-version [options]"
    echo ""
    echo "options:"
    echo "   -z | --Zip      Generate zip file only"

    exit;
}

function LOG {
    echo "$*"
}

function ERR {
    LOG "[ERROR] $*"
}

function INFO {
    LOG "[INFO ] $*"
}

function prepareWorkingDirectory {
    OLD_DIR="${NAME}-${OLDV}"
    NEW_DIR="${NAME}-${NEWV}"
    if [ -d "${NEW_DIR}" ]; then
        ERR "${NEW_DIR} directory is already exists."
        exit;
    fi
    if [ -d "${OLD_DIR}" ]; then
        mv ${OLD_DIR} ${NEW_DIR}
        INFO "${OLD_DIR} moved to ${NEW_DIR}"
    else
        mkdir ${NEW_DIR}
        if [ -d "${NEW_DIR}" ]; then
            LOG "${NEW_DIR} directory is created."
        fi
    fi
}

function unpackingWar {
    if [ ! -f "${WARF}" ]; then
        ERR "${WARF} file is not exists."
        exit;
    fi
    
    cd ${WDIR}
    INFO "Go to ${WDIR} directory."
    jar xvf ${WARF}
    INFO "${WARF} file is decompressed."
    cd ${PWD}
}

function generateZipFile {
    ZIPF="../${NAME}-${NEWV}.zip"

    cd ${WDIR}
    zip -r ${ZIPF} * .[^.]*
    if [ -f "${ZIPF}" ]; then
        INFO "${ZIPF} is created."
    fi
    cd ${PWD}
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
INFO "WDIR: ${WDIR}"
INFO "WARF: ${WARF}"
INFO "NAME: ${NAME}"
INFO "OLDV: ${OLDV}"
INFO "NEWV: ${NEWV}"
INFO "ONLY_ZIP: ${ONLY_ZIP}"
sleep 1;

# prepare working directory
prepareWorkingDirectory;

# unpacking war
unpackingWar;

# generate zip file
generateZipFile;

exit;
#!/bin/bash
############################################
# syncFromLocalToServer.sh
# Open-Box srl - 2019
# Andrea Badii
############################################
EXCLUDE_FILE="_sync/rsync_exclude_server_information_security.txt"
SRV_NAME="aru-vm-ubu2004board-datawarehousing-170"
SOURCE_DIR="./src/"
DEST_ROOT="/home/vhosts/free-code-camp-is.obdem.eu/current"
DEST_DIR="${DEST_ROOT}/${SOURCE_DIR}"
DEST_SSH="root@${SRV_NAME}:${DEST_DIR}"
DRY_RUN=""
DRY_RUN="--dry-run"

CMD_NAME="syncFromLocalToServer"

copyingScp()
{

CMD="scp  ./ansible/roles/deploy/files/_env.dist root@${SRV_NAME}:${DEST_ROOT}/.env"
echo ${CMD}
CMD="scp  ./ansible/roles/deploy/files/_env.dist root@${SRV_NAME}:${DEST_ROOT}/.env.local"
echo ${CMD}
#CMD="scp  ./*.sh root@${SRV_NAME}:${DEST_ROOT}/"
#echo ${CMD}

}


rsyncWithouDelete()
{

#################################### without delete

CMD="rsync -az --force --stats --exclude-from=${EXCLUDE_FILE} -e \"ssh -p22\" ./*.sh root@${SRV_NAME}:${DEST_ROOT}/ ${DRY_RUN}"
echo ${CMD}

CMD="rsync -az --force --stats --exclude-from=${EXCLUDE_FILE} -e \"ssh -p22\" ./public/build/ root@${SRV_NAME}:${DEST_ROOT}/public/build/ ${DRY_RUN}"
echo ${CMD}

#CMD="rsync -az --force --stats --exclude-from=${EXCLUDE_FILE} -e \"ssh -p22\" \"./public/*.png\" root@${SRV_NAME}:${DEST_ROOT}/public/ ${DRY_RUN}"
#echo ${CMD}


CMD="rsync -az --force --stats --exclude-from=${EXCLUDE_FILE} -e \"ssh -p22\" ./public/vendor/ root@${SRV_NAME}:${DEST_ROOT}/public/vendor/ ${DRY_RUN}"
echo ${CMD}

}


rsyncWithDelete()
{

#################################### with delete
CMD="rsync -az --force --delete --stats --exclude-from=${EXCLUDE_FILE} -e \"ssh -p22\" ./ root@${SRV_NAME}:${DEST_ROOT}/ ${DRY_RUN}"
echo ${CMD}

#CMD="rsync -az --force --delete --stats  -e \"ssh -p22\" ./ root@${SRV_NAME}:${DEST_ROOT}/ ${DRY_RUN}"
#echo ${CMD}

}


# Routine principale
main()
{
    OWNER=`whoami`
    echo "command exectud by: ${OWNER}"
    echo "=================="
    echo "${CMD_NAME}"
    echo ""
    echo "Install su ${SRV_NAME}"
    echo ""
    echo "Source Directory: ${SOURCE_DIR}"
    echo "Destination Directory: ${DEST_DIR}"

    echo "Sync ${CMD_NAME}:"
    echo "Sync ${CMD_NAME}:"
    echo "Sync ${CMD_NAME}:"
    read -t 3 -p "Premi INVIO per continuare o aspetta 03 secondi...." ; echo ;

#    echo ""
#    copyingScp
#    echo ""
#    rsyncWithouDelete
    echo ""
    rsyncWithDelete

}

main
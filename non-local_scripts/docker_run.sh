source ../container-name.sh
IMAGE_NAME=$1

if [ $# -lt 1 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image>" 
    echo "+ only iceccd:"
    echo "+ $0 reliableembeddedsystems/${CONTAINER_NAME}:${BRANCH}"
    echo "+ (on one machine) iceccd and central scheduler:"
    echo "+ $0 reliableembeddedsystems/${CONTAINER_NAME}:${BRANCH} sched"
    exit
fi

echo "We'll start iceccd here"

if [[ $2 = sched ]]; then
   echo "We'll start the scheduler here as well"
   SCHED="-e ICECC_ENABLE_SCHEDULER=1"
fi

# remove currently running containers
echo "+ ID_TO_KILL=\$(docker ps -a -q  --filter ancestor=$1)"
ID_TO_KILL=$(docker ps -a -q  --filter ancestor=$1)

echo "+ docker ps -a"
docker ps -a
echo "+ docker stop ${ID_TO_KILL}"
docker stop ${ID_TO_KILL}
echo "+ docker rm -f ${ID_TO_KILL}"
docker rm -f ${ID_TO_KILL}
echo "+ docker ps -a"
docker ps -a

set -x
docker run --name icecream_container -d ${SCHED} --net=host ${IMAGE_NAME}
set +x

# Bootstrapping the Kubernetes Control Plane

#### TODO(ji): ansible-fy this

#
# ACHTUNG: 07-controllers.sh and 08-controllers.sh hardwire the number of controllers (3)
# TODO(ji): parametrize this

chmod 755 09-workers.sh
for worker in ${KWORKERS[@]}; do
  scp 09-workers.sh ${SSHUSER}@${worker}.${GCP_ZONE}.${GCP_PROJECT}: &
done
wait
for worker in ${KWORKERS[@]}; do
  ssh ${SSHUSER}@${worker}.${GCP_ZONE}.${GCP_PROJECT} ./09-workers.sh
done

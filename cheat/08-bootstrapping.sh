# Bootstrapping the Kubernetes Control Plane

#### TODO(ji): ansible-fy this

#
# ACHTUNG: 07-controllers.sh and 08-controllers.sh hardwire the number of controllers (3)
# TODO(ji): parametrize this

chmod 755 08-controllers.sh
for controller in ${KCONTROLLERS[@]}; do
  scp 08-controllers.sh ${SSHUSER}@${controller}.${GCP_ZONE}.${GCP_PROJECT}: &
done
wait
for controller in ${KCONTROLLERS[@]}; do
  ssh ${SSHUSER}@${controller}.${GCP_ZONE}.${GCP_PROJECT} ./08-controllers.sh
done

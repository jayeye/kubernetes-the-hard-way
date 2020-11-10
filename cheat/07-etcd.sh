# Bootstrapping the etcd Cluster


## Bootstrapping an etcd Cluster Member

### Download and Install the etcd Binaries

#### TODO(ji): ansiblefy this


chmod 755 07-controllers.sh
for controller in ${KCONTROLLERS[@]}; do
  scp 07-controllers.sh ${SSHUSER}@${controller}.${GCP_ZONE}.${GCP_PROJECT}: &
done
wait
for controller in ${KCONTROLLERS[@]}; do
  ssh ${SSHUSER}@${controller}.${GCP_ZONE}.${GCP_PROJECT} ./07-controllers.sh
done

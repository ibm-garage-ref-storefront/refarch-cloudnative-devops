oc new-project jboss-eap-quickstarts

oc apply -f pvc/maven-repo-pvc.yaml
oc apply -f pvc/maven-source-pvc.yaml

oc apply -f tasks/aas-maven-task.yaml
oc apply -f tasks/aas-sonar-task.yaml

oc apply -f pipelines/aas-pipeline.yaml

# openshift does not like the yaml, post it via the web console
#oc apply -f aas-pl-run.yaml
#sleep 10
#PL=$(tkn pr list | grep Running | awk '{ print $1 }') && tkn pr logs -f $PL
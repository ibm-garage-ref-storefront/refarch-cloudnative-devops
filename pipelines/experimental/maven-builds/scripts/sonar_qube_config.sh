oc project jboss-eap-quickstarts

export SONARQUBE_URL='http://sonarqube-sonarqube.tools.svc.cluster.local:9000'
export SONARQUBE_PROJECT='jboss-eap-quickstarts'
export SONARQUBE_LOGIN='the sonarqube project access token here'


echo "using SONARQUBE_URL=${SONARQUBE_URL}"
oc delete configmap sonarqube-config 2>/dev/null
oc create configmap sonarqube-config \
    --from-literal SONARQUBE_URL=${SONARQUBE_URL}

oc delete secret sonarqube-access 2>/dev/null
oc create secret generic sonarqube-access \
    --from-literal SONARQUBE_PROJECT=${SONARQUBE_PROJECT} \
    --from-literal SONARQUBE_LOGIN=${SONARQUBE_LOGIN} 

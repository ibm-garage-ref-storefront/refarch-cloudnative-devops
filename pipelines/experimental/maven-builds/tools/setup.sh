oc new-project tools

# Setup Openshift pipelines
echo "###################################################################"
cd pipelines
./install_pipelines.sh
cd ..
echo ""

# Setup sonarqube
echo "###################################################################"
cd sonarqube
./install_sonarqube.sh
cd ..
echo ""

# Setup nexus3
echo "###################################################################"
cd nexus3
./install_nexus3.sh
cd ..
echo ""


# TODO: setup Openshift service mesh

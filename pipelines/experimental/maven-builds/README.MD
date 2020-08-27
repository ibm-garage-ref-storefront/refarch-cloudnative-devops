# Setup Tools

Run the tools/setup.sh script to 
- create the tools namespace;
- installs non-persistent nexus3 in the tools namespace via an operator;
- installs the openshift pipelines in all namespaces via an operator;
- installs sonarqube in the tools namespace via an operator;

Run the command to get the generated nexus3 admin password.

# Install Pipeline.
- Edit the pipeline/aas-maven.yaml file and update the password to access nexus3.
- Run the following command:
  - scripts/setup_pipeline.sh script.
- Create a run via the webconsole by posting the pipeline run yaml.

PL=$(tkn pr list | grep Running | awk '{ print $1 }') && tkn pr logs -f $PL

TODO:
- make nexus use a persistent volume.
- use the source command to set the variables.
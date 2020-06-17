oc get kabanero -o json > ./json/kabanero.json
num_of_pipelines=$(jq '.items[].spec.stacks.pipelines | length' ./json/kabanero.json)

current_version=$(jq --raw-output '.tag_name' ./repo_details.json)
host_url=https://github.com/$REPO_ORG/$REPO_NAME/releases/download/$current_version/default-kabanero-pipelines.tar.gz

# get sha256 from previous step on the zip file
get_sha=$(cat ./256.txt | head -n 1)

echo "$current_version"
# get the add_pipeline_template.json and replace the url, id and sha256 values and store it in another file
jq --compact-output '.[0].https.url="'$host_url'" | .[0].id="'$kabanero_pipeline_id'" | .[0].sha256="'$get_sha'"' ./json/pipeline_template.json > ./json/pipeline_modified_template.json


if (( $num_of_pipelines == 0 )); then
    echo "The Kabanero Custom Resource has no pipelines"
    cat ./json/pipeline_modified_template.json

    echo "applying the new pipeline custom resource..."

    oc patch Kabanero/kabanero -p '{"spec":{"stacks":{"pipelines":['$(cat ./json/pipeline_modified_template.json)']}}}' --type=merge --loglevel=9  
else
    echo "The Kabanero Custom Resource has " $num_of_pipelines  " pipelines"
    
    # store current pipelines from the kabanero custom resource
    jq '.items[].spec.stacks.pipelines' ./json/kabanero.json > ./json/current_pipelines.json
    echo "printing current pipelines... " 
    cat ./json/current_pipelines.json

    jq --slurp 'add' ./json/current_pipelines.json ./json/pipeline_modified_template.json > ./json/merged_pipelines.json

    echo "printing merged pipelines..."
    cat ./json/merged_pipelines.json
    oc patch Kabanero/kabanero -p '{"spec":{"stacks":{"pipelines":['$(cat ./json/merged_pipelines.json)']}}}' --type=merge --loglevel=9

fi

echo "we are done"
# Custom Pipelines for Storefront Springboot services

- Create the tasks.

```
oc apply -f --recursive tasks -n kabanero
```

You see the below tasks created.

```
$ tkn task ls -n kabanero
NAME                                         AGE
custom-java-spring-boot2-gitops-task         6 days ago
custom-java-spring-boot2-health-check-task   6 days ago
custom-java-spring-boot2-pact-task           6 days ago
custom-java-spring-boot2-sonarqube-task      1 week ago
custom-java-spring-boot2-test-task           1 week ago
```

- Create the pipeline.

```
oc apply -f --recursive pipelines -n kabanero
```

You see the pipelines as follows.

```
$ tkn pipeline ls -n kabanero
NAME                                       AGE           LAST RUN                                                     STARTED      DURATION     STATUS
storefront-springboot-pl                   1 week ago    storefront-springboot-pl-run-fsp9q                           6 days ago   7 minutes    Succeeded
```

- Create the necessary bindings.

```
oc apply -f --recursive bindings -n tekton-pipelines
```

You see them as follows.

```
$ oc get triggerbindings -n tekton-pipelines
NAME                                                        AGE
storefront-springboot-pl-pullrequest-binding                27d
storefront-springboot-pl-push-binding                       27d
```

- Create the necessary trigger templates.

```
oc apply -f --recursive templates -n tekton-pipelines
```

You see them as follows.

```
$ oc get triggertemplates -n tekton-pipelines
NAME                                             AGE
storefront-springboot-pl-template                27d
```

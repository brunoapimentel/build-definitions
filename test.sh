#!/bin/bash
set -ex

oc apply -f task/git-clone/0.1
oc apply -f task/buildah-rhtap/0.1
oc apply -f pipelines/rhtap-test

tkn pipeline start rhtap-test \
    -p git-url="https://github.com/brunoapimentel/sample-nodejs-app" \
    -p revision="main" \
    -p output-image="quay.io/bpimente/test-images:test-rhtap" \
    -p dockerfile="Dockerfile" \
    --use-param-defaults \
    -w name=workspace,volumeClaimTemplateFile=workspace.yaml


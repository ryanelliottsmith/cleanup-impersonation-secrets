#!/bin/bash

NAMESPACE="test-ns"
MAX_RETRIES=10
RETRY_DELAY=5
BATCH_SIZE=1000


export NAMESPACE

kubectl --kubeconfig=/tmp/kubeconfig.yml get secrets -n $NAMESPACE --no-headers -o custom-columns=":metadata.name" > secrets-list.txt
split -l $BATCH_SIZE secrets-list.txt secret_chunk_

for _file in secret_chunk_*
  do
  kubectl --kubeconfig=/tmp/kubeconfig.yml delete secret -n $NAMESPACE $(awk '{printf "%s ", $0}' $_file)
  done

rm secrets-list.txt
rm secret_chunk_*

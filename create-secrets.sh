#!/bin/bash

NAMESPACE="test-ns"
NUM_SECRETS=10000
SECRET_SIZE=3000 # 10KB

# Ensure the namespace exists
kubectl create namespace $NAMESPACE --dry-run=client -o yaml | kubectl apply -f -

# Function to create a secret with random data
create_secret() {
  local secret_name=$1
  local namespace=$2
  local data=$(head -c $SECRET_SIZE /dev/urandom | base64)

  cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: $secret_name
  namespace: $namespace
data:
  random-data: $data
EOF
}

# Create secrets in batches
for i in $(seq 1 $NUM_SECRETS); do
  create_secret "new-secret-$i" $NAMESPACE &
  if (( $i % 100 == 0 )); then
    wait # Wait for background jobs to complete every 100 secrets
  fi
done

# Wait for any remaining background jobs to complete
wait

echo "Created $NUM_SECRETS secrets in namespace $NAMESPACE."
#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

WORKLOAD="$SCRIPT_DIR/../config/workload.yaml"
PIPELINE="$SCRIPT_DIR/../config/pipeline.yaml"
PROVIDER_STUB="$SCRIPT_DIR/../config/encoding-api-stub.yaml"

kubectl apply -f "$PROVIDER_STUB"
kubectl apply -f "$PIPELINE"

kubectl delete -f "$WORKLOAD" || true
kubectl apply -f "$WORKLOAD"

tanzu apps workload tail consumer

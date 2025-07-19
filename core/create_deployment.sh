#!/bin/bash
set -e

RELEASE_NAME="$1"
VALUES_FILE="$2"
NAMESPACE="$3"

echo "Applying values file: $VALUES_FILE"

helm upgrade --install "$RELEASE_NAME" ./chart -f "$VALUES_FILE" -n "$NAMESPACE" --create-namespace --atomic --wait

echo "Deployment created successfully."

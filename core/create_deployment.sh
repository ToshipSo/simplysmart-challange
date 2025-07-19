#!/bin/bash
set -e

RELEASE_NAME="$1"
VALUES_FILE="$2"
NAMESPACE="$3"

echo "Applying values file: $VALUES_FILE"

helm upgrade --install "$RELEASE_NAME" ./chart -f "$VALUES_FILE" -n "$NAMESPACE" --create-namespace

echo "Deployment created successfully."

echo "Waiting for deployment to be ready..."
APP=$(kubectl get deployments -n services \
  -o go-template='{{range .items}}{{if eq (index .metadata.annotations "meta.helm.sh/release-name") "my-app"}}{{.metadata.name}}{{"\n"}}{{end}}{{end}}')

kubectl rollout status deploy -n "$NAMESPACE" $APP
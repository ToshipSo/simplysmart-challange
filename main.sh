#!/bin/bash
set -e

SCRIPT_DIR="$(pwd)/core"

help() {
  echo "Usage: $0 {setup|deploy|status} [args...]"
  exit 1
}

case "$1" in
  setup)
    bash "$SCRIPT_DIR/install_helm.sh"
    bash "$SCRIPT_DIR/install_keda.sh"
    ;;
  deploy)
    RELEASE_NAME=$2
    VALUES_FILE=$3
    NAMESPACE=$4
    if [ -z "$VALUES_FILE" ]; then
      echo "Usage: $0 deploy <release name> <values file path> <namespace>"
      exit 1
    fi
    bash "$SCRIPT_DIR/create_deployment.sh" "$RELEASE_NAME" "$VALUES_FILE" "$NAMESPACE"
    ;;
  *)
    help
    ;;
esac

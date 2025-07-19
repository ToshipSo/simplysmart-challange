#!/bin/bash
set -e

echo "Installing KEDA..."

helm repo add kedacore https://kedacore.github.io/charts
helm repo update

helm upgrade --install keda kedacore/keda --namespace keda --create-namespace

echo "KEDA installed successfully."

echo "Waiting for KEDA operator to be ready..."
kubectl rollout status deploy keda-operator -n keda

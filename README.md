# KEDA-Based Kubernetes Deployment CLI

This project provides a simple Bash-based CLI tool (`main.sh`) to automate the installation of Helm, KEDA, and event-driven autoscaling deployments in a Kubernetes cluster using Helm charts.

---

## Prerequisites

Ensure the following are installed and configured before using the script:

- [`kubectl`](https://kubernetes.io/docs/tasks/tools/)
- `bash` (Shell)
- `curl` (for downloading Helm)
- Access to a running **Kubernetes cluster** (e.g., via kubeconfig)

---

## Usage

The CLI is driven by a single Bash script: `main.sh`  
You can run it using:

```bash
bash main.sh <command>
```

### 1. Show Help / Usage
```bash
bash main.sh help
```

### 2. Setup Cluster with Helm & KEDA
```bash
bash main.sh setup
```
* Installs helm (if not already installed)
* Installs the KEDA operator in the Kubernetes cluster

### 3. Deploy with KEDA Autoscaling
```bash
bash main.sh deploy <release-name> <values-file> <namespace>
```
* Deploys a Helm chart with the provided configuration and KEDA-based event-driven autoscaling.
* `values-file` should be a Helm-compatible YAML file defining your app, resource limits, ports, autoscaling, and KEDA trigger details (e.g., Kafka, RabbitMQ, CPU/memory).
* You can find default values file at `chart/values.yaml`


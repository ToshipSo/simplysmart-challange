#!/bin/bash
set -e

echo "Detecting Platform..."

OS="$(uname -s)"

case "$OS" in
  Linux) PLATFORM="linux" ;;
  Darwin) PLATFORM="darwin" ;;
  *)
    echo "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "Detected platform: $PLATFORM"

# Check if Helm is already installed
if which helm &>/dev/null; then
  echo "Helm is already installed at $(which helm)"
  helm version
  exit 0
fi

echo "Installing Helm..."

# Fetch latest Helm version
LATEST_VERSION=$(curl -s https://api.github.com/repos/helm/helm/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')

if [ -z "$LATEST_VERSION" ]; then
  echo "Failed to fetch latest Helm version."
  exit 1
fi

ARCH=$(uname -m)
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  arm64|aarch64) ARCH="arm64" ;;
  *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

HELM_TAR="helm-v${LATEST_VERSION}-${PLATFORM}-${ARCH}.tar.gz"
DOWNLOAD_URL="https://get.helm.sh/${HELM_TAR}"

curl -LO "$DOWNLOAD_URL"
tar -zxvf "$HELM_TAR"
mv "${PLATFORM}-${ARCH}/helm" /usr/local/bin/helm

# Clean up
rm -rf "$HELM_TAR" "${PLATFORM}-${ARCH}"

echo "Helm installed successfully."
helm version

#!/bin/bash

echo "Checking for updates..."

get_latest_convertx_version() {
  curl -s "https://api.github.com/repos/C4illin/ConvertX/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/'
}

get_current_version() {
  if [ -f .docker-publish ]; then
    grep '"version":' .docker-publish | sed -E 's/.*"([^"]+)".*/\1/'
  else
    echo "0.0.0"
  fi
}
get_image_name() {
  if [ -f .docker-publish ]; then
    grep '"dockerImageName":' .docker-publish | sed -E 's/.*"([^"]+)".*/\1/'
  else
    echo "ghcr.io/energypatrikhu/convertx"
  fi
}

IMAGE_NAME=$(get_image_name)
CURRENT_CONVERTX_VERSION=$(get_current_version)
LATEST_CONVERTX_VERSION=$(get_latest_convertx_version)

if [ -z "$LATEST_CONVERTX_VERSION" ]; then
  echo "Error fetching latest versions. Exiting."
  exit 1
fi

echo "[ConvertX] Current version: $CURRENT_CONVERTX_VERSION"
echo "[ConvertX] Latest version: $LATEST_CONVERTX_VERSION"

if [ "$CURRENT_CONVERTX_VERSION" != "$LATEST_CONVERTX_VERSION" ]; then
  echo "New version available. Updating .docker-publish file."

  # Update .docker-publish file
  cat > .docker-publish <<EOL
{
  "dockerImageName": "$IMAGE_NAME",
  "version": "$LATEST_CONVERTX_VERSION"
}
EOL
  echo ".docker-publish file updated to version $LATEST_CONVERTX_VERSION"

  # Build and push Docker image
  echo "Building and pushing Docker image $IMAGE_NAME:$LATEST_CONVERTX_VERSION"
  docker build --no-cache -t $IMAGE_NAME:$LATEST_CONVERTX_VERSION -t $IMAGE_NAME:latest .
  docker push $IMAGE_NAME:$LATEST_CONVERTX_VERSION
  docker push $IMAGE_NAME:latest
  echo "Docker image $IMAGE_NAME:$LATEST_CONVERTX_VERSION built and pushed."

  # Commit and push changes to GitHub
  echo "Committing and pushing changes to GitHub."
  git add .docker-publish
  git commit -m "Update to version $LATEST_CONVERTX_VERSION"
  git push origin main
  echo "Changes pushed to GitHub."
else
  echo "No new version available. Current version is up-to-date."
fi

#!/usr/bin/bash

set -e

if [ "$EUID" -eq 0 ]; then
  echo "Please do not run as root"
  exit
fi

github_api_url="https://api.github.com/repos/mengmeet/PowerControl/releases/latest"
package="PowerControl"

echo "installing $package"

temp=$(mktemp -d)

chmod -R +w "${HOME}/homebrew/plugins/"
plugin_dir="${HOME}/homebrew/plugins/${package}"
mkdir -p $plugin_dir

use_jq=false
if [ -x "$(command -v jq)" ]; then
  use_jq=true
fi

RELEASE=$(curl -s "$github_api_url")

if [[ $use_jq == true ]]; then
  echo "Using jq"
  MESSAGE=$(echo "$RELEASE" | jq -r '.message')
  RELEASE_VERSION=$(echo "$RELEASE" | jq -r '.tag_name')
  RELEASE_URL=$(echo "$RELEASE" | jq -r '.assets[0].browser_download_url')
else
  MESSAGE=$(echo $RELEASE | grep "message" | cut -d '"' -f 4)
  RELEASE_URL=$(echo $RELEASE | grep "browser_download_url" | cut -d '"' -f 4)
  RELEASE_VERSION=$(echo $RELEASE | grep "tag_name" | cut -d '"' -f 4)
fi

if [[ "$MESSAGE" != "null" ]]; then
  echo "error: $MESSAGE" >&2
  exit 1
fi

if [ -z "$RELEASE_URL" ]; then
  echo "Failed to get latest release" >&2
  exit 1
fi

temp_file="${temp}/${package}.tar.gz"

echo "Downloading $package $RELEASE_VERSION"
curl -L "$RELEASE_URL" -o "$temp_file"

sudo tar -xzf "$temp_file" -C $temp
echo "Removing ryzenadj and portio.so from new package and backing up existing ones before installing new package"
echo "Do not use this version of the script if you want to use the provided copies from mengmeet, as they will not be kept up-to-date by this modified installation script."
sudo rm "${temp}/${package}/bin/ryzenadj"
if [ -e "${plugin_dir}/bin/ryzenadj" ]; then
  echo "Restoring previous ryzenadj..."
  sudo mv "${plugin_dir}/bin/ryzenadj" "${temp}/${package}/bin/ryzenadj"
fi  
sudo rm "${temp}/${package}/backend/portio.so"
if [ -e "${plugin_dir}/backend/portio.so" ]; then
  echo "Restoring previous portio.so..."
  sudo mv "${plugin_dir}/backend/portio.so" "${temp}/${package}/backend/portio.so"
fi
sudo rsync -av "${temp}/${package}/" $plugin_dir --delete

rm "$temp_file"
sudo systemctl restart plugin_loader.service

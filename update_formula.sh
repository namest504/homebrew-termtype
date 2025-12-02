#!/bin/bash

FORMULA_FILE="Formula/termtype.rb"
REPO="namest504/termtype"

check_usage() {
  if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 v0.2.4"
    exit 1
  fi
}

get_source_sha() {
  local version=$1
  local url="https://github.com/$REPO/archive/refs/tags/$version.tar.gz"
  
  echo "Downloading source from $url..." >&2
  curl -L -o source.tar.gz "$url" >&2
  local sha
  sha=$(sha256sum source.tar.gz | awk '{print $1}')
  rm source.tar.gz
  echo "$sha"
}

get_binary_shas() {
  local version=$1
  local url="https://github.com/$REPO/releases/download/$version/checksums.txt"
  
  echo "Downloading checksums from $url..." >&2
  curl -L -o checksums.txt "$url" >&2

  if [ ! -f checksums.txt ]; then
      echo "Error: Failed to download checksums.txt" >&2
      exit 1
  fi

  # Extract SHA256s and print them space-separated
  local darwin_arm64=$(grep "termtype_darwin_arm64.tar.gz" checksums.txt | awk '{print $1}')
  local darwin_amd64=$(grep "termtype_darwin_amd64.tar.gz" checksums.txt | awk '{print $1}')
  local linux_arm64=$(grep "termtype_linux_arm64.tar.gz" checksums.txt | awk '{print $1}')
  local linux_amd64=$(grep "termtype_linux_amd64.tar.gz" checksums.txt | awk '{print $1}')

  rm checksums.txt
  echo "$darwin_arm64 $darwin_amd64 $linux_arm64 $linux_amd64"
}

update_formula() {
  local version=$1
  local source_sha=$2
  local darwin_arm64=$3
  local darwin_amd64=$4
  local linux_arm64=$5
  local linux_amd64=$6

  echo "Updating $FORMULA_FILE to version $version..."

  # Update Source
  sed -i "s|url \"https://github.com/$REPO/archive/refs/tags/.*.tar.gz\"|url \"https://github.com/$REPO/archive/refs/tags/$version.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/archive\/refs\/tags/!b;n;c\  sha256 \"$source_sha\"" "$FORMULA_FILE"

  # Update Binaries
  # Darwin ARM64
  sed -i "s|url \".*/termtype_darwin_arm64.tar.gz\"|url \"https://github.com/$REPO/releases/download/$version/termtype_darwin_arm64.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/termtype_darwin_arm64.tar.gz/!b;n;c\      sha256 \"$darwin_arm64\"" "$FORMULA_FILE"

  # Darwin AMD64
  sed -i "s|url \".*/termtype_darwin_amd64.tar.gz\"|url \"https://github.com/$REPO/releases/download/$version/termtype_darwin_amd64.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/termtype_darwin_amd64.tar.gz/!b;n;c\      sha256 \"$darwin_amd64\"" "$FORMULA_FILE"

  # Linux ARM64
  sed -i "s|url \".*/termtype_linux_arm64.tar.gz\"|url \"https://github.com/$REPO/releases/download/$version/termtype_linux_arm64.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/termtype_linux_arm64.tar.gz/!b;n;c\      sha256 \"$linux_arm64\"" "$FORMULA_FILE"

  # Linux AMD64
  sed -i "s|url \".*/termtype_linux_amd64.tar.gz\"|url \"https://github.com/$REPO/releases/download/$version/termtype_linux_amd64.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/termtype_linux_amd64.tar.gz/!b;n;c\      sha256 \"$linux_amd64\"" "$FORMULA_FILE"
}

main() {
  check_usage "$1"
  local version=$1

  local source_sha
  source_sha=$(get_source_sha "$version")
  echo "Source SHA: $source_sha"

  local binary_shas
  binary_shas=$(get_binary_shas "$version")
  # Split the string into array or read into variables
  read -r darwin_arm64 darwin_amd64 linux_arm64 linux_amd64 <<< "$binary_shas"

  echo "Darwin ARM64: $darwin_arm64"
  echo "Darwin AMD64: $darwin_amd64"
  echo "Linux ARM64:  $linux_arm64"
  echo "Linux AMD64:  $linux_amd64"

  update_formula "$version" "$source_sha" "$darwin_arm64" "$darwin_amd64" "$linux_arm64" "$linux_amd64"
  
  echo "Done! Updated $FORMULA_FILE to $version."
}

main "$@"

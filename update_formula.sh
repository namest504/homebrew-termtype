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

update_formula() {
  local version=$1
  local source_sha=$2

  echo "Updating $FORMULA_FILE to version $version..."

  # Update Source
  sed -i "s|url \"https://github.com/$REPO/archive/refs/tags/.*.tar.gz\"|url \"https://github.com/$REPO/archive/refs/tags/$version.tar.gz\"|" "$FORMULA_FILE"
  sed -i "/archive\/refs\/tags/!b;n;c\  sha256 \"$source_sha\"" "$FORMULA_FILE"
}

main() {
  check_usage "$1"
  local version=$1

  local source_sha
  source_sha=$(get_source_sha "$version")
  echo "Source SHA: $source_sha"

  update_formula "$version" "$source_sha"
  
  echo "Done! Updated $FORMULA_FILE to $version."
}

main "$@"

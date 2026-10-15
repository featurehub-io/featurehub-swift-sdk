#!/bin/sh
# get the generator used for the mocks, at the same version as the Cuckoo runtime the tests use
set -e
cd "$(dirname "$0")"

GENERATOR=cuckoo_generator
# the generator doesn't report its own version, so we record the one we downloaded next to it
VERSION_FILE=cuckoo_generator.version

# the version Cuckoo is pinned to in Package.resolved (can be overridden with CUCKOO_VERSION)
REQUIRED=${CUCKOO_VERSION:-$(awk '/"identity" *: *"cuckoo"/ { found = 1 } found && /"version"/ { gsub(/[^0-9.]/, ""); print; exit }' Package.resolved)}

if [ -z "$REQUIRED" ]; then
  echo "Couldn't find the Cuckoo version in Package.resolved, run 'swift package resolve' first or set CUCKOO_VERSION"
  exit 1
fi

INSTALLED=""
if [ -x "$GENERATOR" ] && [ -f "$VERSION_FILE" ]; then
  INSTALLED=$(cat "$VERSION_FILE")
fi

if [ "$INSTALLED" != "$REQUIRED" ]; then
  if [ -e "$GENERATOR" ]; then
    echo "Cuckoo generator is version ${INSTALLED:-unknown}, replacing it with $REQUIRED"
  else
    echo "Cuckoo generator not installed, downloading $REQUIRED"
  fi

  rm -f "$GENERATOR" "$VERSION_FILE"
  ./cuckoo_run --download "$REQUIRED"

  if [ ! -x "$GENERATOR" ]; then
    echo "Failed to download the Cuckoo generator $REQUIRED"
    exit 1
  fi

  echo "$REQUIRED" > "$VERSION_FILE"
else
  echo "Cuckoo generator $REQUIRED is already installed"
fi

./generate_mocks.sh

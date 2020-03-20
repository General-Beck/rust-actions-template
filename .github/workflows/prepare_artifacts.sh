#!/bin/bash
set -e # fail on any error
set -u # treat unset variables as error
set -v # verbose output
# ARGUMENT $1 CARGO_TARGET

echo "_____ Post-processing binaries _____"

mkdir -p artifacts/
cd artifacts/

for binary in $(ls)
do
  cp -v ../target/$1/release/$binary $binary
  rhash -v --sha3-256 $binary -o $binary.sha3 #Calculating checksum
done

rm -rf artifacts/*

#!/bin/bash
set -e # fail on any error
set -u # treat unset variables as error

# ARGUMENT $1 CARGO_TARGET

mkdir -p ./artifacts/
cd ./target/$1/release/
echo "_____ Find binary files _____"
find . -maxdepth 1 -type f ! -size 0 -exec grep -IL . "{}" \; | cut -c 3-
for binary in $(find . -maxdepth 1 -type f ! -size 0 -exec grep -IL . "{}" \; | cut -c 3- )
do
  cp -v $binary ../$1/../artifacts/$binary
  rhash --sha3-256 ../$1/../artifacts/$binary -o ../$1/../artifacts/$binary.sha3 #Calculating checksum
  echo "sha3: "$(cat ../$1/../artifacts/$binary.sha3)
  #rm -f $binary
done
#cd ../$1/..
#echo "_____ Clean target dir _____"
#find ./target/$1/release -maxdepth 1 -type f -delete;
#rm -f  ./target/.rustc_info.json;
#rm -rf ./target/$1/release/{deps,.fingerprint}/

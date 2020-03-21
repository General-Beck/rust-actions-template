#!/bin/bash
set -e # fail on any error
set -u # treat unset variables as error

# ARGUMENT $1 CARGO_TARGET
#Set additional dir path
if [ "${1}" == "" ]; then
  dir=""
else
  dir=".."
fi
mkdir -p ./artifacts/
cd ./target/$1/release/
echo "_____ Find binary files in target _____"
find . -maxdepth 1 -type f ! -size 0 -exec grep -IL . "{}" \; | cut -c 3-
echo "_____ Move binaries to artifacts folder and calculete checksum _____"
for binary in $(find . -maxdepth 1 -type f ! -size 0 -exec grep -IL . "{}" \; | cut -c 3- )
do
  mv -v $binary ../$dir/../artifacts/$binary
  rhash --sha3-256 ../$dir/../artifacts/$binary -o ../$dir/../artifacts/$binary.sha3 #Calculating checksum
  echo "sha3: "$(cat ../$dir/../artifacts/$binary.sha3)
  #rm -f $binary
done
#cd ../$dir/..
#echo "_____ Clean target dir _____"
#find ./target/$dir/release -maxdepth 1 -type f -delete;
#rm -f  ./target/.rustc_info.json;
#rm -rf ./target/$dir/release/{deps,.fingerprint}/

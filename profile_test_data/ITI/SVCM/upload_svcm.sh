#!/bin/bash
# basic bash script to upload test data for SVCM

if [ $# -lt 2 ]
then
	echo "Usage:"
	echo "$0 <url> <folder>"
	echo "Example: http://host/fhir/ CodeSystem"
	exit
fi

url=$1
folder=$2

pushd ${folder}

for f in *
do
	fileid=$(basename ${f} .xml)
	wget --method=PUT --body-file=${f} --output-document=/dev/null --header='Content-Type: application/fhir+xml;charset=UTF-8' --server-response "${url}${folder}/${fileid}"
done

popd
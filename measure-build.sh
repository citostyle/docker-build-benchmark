#!/bin/bash

FOLDER="repo"
IMAGE="msr/benchmark"
IMAGEREPEAT="msr/benchmark2"
REPOPREFIX="https://www.github.com/"
REPOPATH=$1
REPO=$REPOPREFIX$REPOPATH
OUTFILE=$2 

# clean up - delete container and images
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)

git clone $REPO $FOLDER
if ! [ $? -eq 0 ]; then
    echo "$REPO;clonefail" >> "$OUTFILE"
    exit;
fi

cd $FOLDER
START=$(date +%s)
docker build -t $IMAGE .
STATUS=$?
END=$(date +%s)
DIFF=$((END-START))
echo "$REPO, $DIFF"
cd ..


if [ $STATUS -eq 0 ]; then
    SUCCESS=1
else
    SUCCESS=0
fi
echo "$REPOPATH;$DIFF;$SUCCESS" >> "$OUTFILE"


# post analysis clean up
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
rm -rf $FOLDER

#!/usr/bin/env bash

#ISODATE=`date --iso`
ISODATE=2024-11-06

get_artifact_and_unpack() {
    TPLATFORM="$1"
    TASKID="$2"

    # ARTIFACT=browsertime-results.tgz
    ARTIFACT=browsertime-videos-original
    ARTIFACT_URL="https://firefox-ci-tc.services.mozilla.com/api/queue/v1/task/${TASKID}/runs/0/artifacts/public/test_info/${ARTIFACT}.tgz"

    #curl --fail --silent --show-error "${ARTIFACT_URL}" --output "$ARTIFACTF";
    wget "${ARTIFACT_URL}"
    tar xfz ${ARTIFACT}.tgz

    # select data files and copy/rename.
    ARTIFACT_BASE="$ISODATE-$TPLATFORM";

    ARTIFACT1_NAME=cold-browsertime.json
    ARTIFACT1=`find ./$ARTIFACT -type f -name $ARTIFACT1_NAME`
    cp ${ARTIFACT1} ./${ARTIFACT_BASE}-${ARTIFACT1_NAME};

    ARTIFACT2_NAME=1-original.mp4
    ARTIFACT2=`find ./$ARTIFACT -type f -name $ARTIFACT2_NAME | grep cold`
    cp ${ARTIFACT2} ./${ARTIFACT_BASE}.mp4;

    rm -rf ${ARTIFACT} ${ARTIFACT}.tgz
}


#get_artifact_and_unpack "linux-firefox-amazon" "LrntcFBZSBW0fxJXJIlTxg"

# 2024-11-06
# revision: 66c06d5d735b9b7d7ccb0e85f326c28f7d19dd7d
#get_artifact_and_unpack "android-chrome-amazon" ""
#get_artifact_and_unpack "android-firefox-amazon" ""
#get_artifact_and_unpack "linux-chrome-amazon" ""
#get_artifact_and_unpack "linux-firefox-amazon" ""
#get_artifact_and_unpack "win11-chrome-amazon" ""
#get_artifact_and_unpack "win11-firefox-amazon" ""


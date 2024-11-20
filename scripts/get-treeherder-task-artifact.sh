#!/usr/bin/env bash

#ISODATE=`date --iso`
ISODATE=2024-11-15

ITERATIONFINDER=$MOZPERFAX/bin/moz-perf-x-extract.browsertime_iteration.exe

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

    # find browsertime result json file
    ARTIFACT1_NAME=cold-browsertime.json
    ARTIFACT1_ONAME=${ARTIFACT_BASE}-${ARTIFACT1_NAME};
    ARTIFACT1=`find ./$ARTIFACT -type f -name $ARTIFACT1_NAME`
    cp ${ARTIFACT1} ./${ARTIFACT1_ONAME};

    # use it to select iteration to use for rest of extraction.
    # Note browsertime numbering starts at 0, artifact numbering starts at 1
    ITER=`$ITERATIONFINDER ./${ARTIFACT1_ONAME}`
    ITER=$((ITER + 1))

    # find video file.
    ARTIFACT2_NAME=${ITER}-original.mp4
    ARTIFACT2=`find ./$ARTIFACT -type f -name $ARTIFACT2_NAME | grep cold`
    cp ${ARTIFACT2} ./${ARTIFACT_BASE}.mp4;

    #rm -rf ${ARTIFACT} ${ARTIFACT}.tgz

    rm -rf ${ARTIFACT}
    mv ${ARTIFACT}.tgz ${ARTIFACT_BASE}-${ARTIFACT}.tgz
}


# 2024-11-11
# revision: 544768c159ebb03a8419e5fe3b1135bbce4965a5 amarc@mozilla.com
#get_artifact_and_unpack "android-chrome-amazon" "XVtnHMq5RIKSjctXmONWUA"
#get_artifact_and_unpack "android-firefox-amazon" "FY3DkYW_TqK-OAAnRWUCag"
#get_artifact_and_unpack "linux-chrome-amazon" "bSrPsvpRRyuV8Viufi2ThA"
#get_artifact_and_unpack "linux-firefox-amazon" "MK_AQzRzTxicH4mqSoLwmA"
#get_artifact_and_unpack "win11-chrome-amazon" "AMQmRGlnQECayEI5w7AFzw"
#get_artifact_and_unpack "win11-firefox-amazon" "ac68E6Y1R5eYweHTaGtNEQ"

# 2024-11-13
# revision: 723946b9a47990aa6253585366bb18863de4df33
#get_artifact_and_unpack "android-chrome-amazon" "TZYbceDiQmi9QFRD-p5SFA"
#get_artifact_and_unpack "android-firefox-amazon" "SRBmXxxqQgqdh93HmOnarA"
#get_artifact_and_unpack "linux-chrome-amazon" ""
#get_artifact_and_unpack "linux-firefox-amazon" "TL0sHKldQ1e_yCOZnRqwAQ"
#get_artifact_and_unpack "win11-chrome-amazon" "Oa70G72URmi3IWnVPCBjfA"
#get_artifact_and_unpack "win11-firefox-amazon" "HJZ7SBoBT_Cm27D5w05_3g"

# 2024-11-15T09:34:47Z
# revision: f918befd42312cdf96757bea838a55620ce4cb7f
# pstanciu@mozilla.com, id(482802694), push_id(1533676)
get_artifact_and_unpack "android-chrome-amazon" "AiNhygfUTBC1JigtAFejKg"
get_artifact_and_unpack "android-firefox-amazon" "Janmma67QIiH7tIK-RXgyQ"


#get_artifact_and_unpack "linux-chrome-amazon" ""
#get_artifact_and_unpack "linux-firefox-amazon" ""

# revision: 563a9354bae0035e1cf01227bc28be4a80a7d5e5
# 2024-11-15 17:15 aglavic@mozilla.com id(482,873,628) push_id(1,534,036)
#get_artifact_and_unpack "win11-chrome-amazon" "FzHE0G0XTMSAj0rUpJzLmg"
#get_artifact_and_unpack "win11-firefox-amazon" ""

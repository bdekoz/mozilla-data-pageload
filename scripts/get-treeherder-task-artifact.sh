#!/usr/bin/env bash

ISODATE=`date --iso`
TPLATFORM=linux-firefox-amazon

ARTIFACT=browsertime-results.tgz
TASKID=LrntcFBZSBW0fxJXJIlTxg
ARTIFACT_URL="https://firefox-ci-tc.services.mozilla.com/api/queue/v1/task/${TASKID}/runs/0/artifacts/public/test_info/${ARTIFACT}"

#curl --fail --silent --show-error "${ARTIFACT_URL}" --output "$ISODATE-$TPLATFORM-$ARTIFACT";

wget "${ARTIFACT_URL}" -O "$ISODATE-$TPLATFORM-$ARTIFACT";

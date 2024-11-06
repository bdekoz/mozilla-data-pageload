#!/usr/bin/env bash

ISODATE=`date --iso`

LINUX_URL="https://sql.telemetry.mozilla.org/api/queries/103481/results.json?api_key=gGZtKjMWvDxX1ZowDO1ylPLpb7geLfydJOfPwacA"
WIN_URL="https://sql.telemetry.mozilla.org/api/queries/103544/results.json?api_key=77QUfZNd45ckUuoTDv9thesptPNWyE2KC2rzdVTz"
DROID_URL="https://sql.telemetry.mozilla.org/api/queries/103544/results.json?api_key=77QUfZNd45ckUuoTDv9thesptPNWyE2KC2rzdVTz"


curl --fail --silent --show-error "${LINUX_URL}" --output "$ISODATE-linux.json";

curl --fail --silent --show-error "${WIN_URL}" --output "$ISODATE-win11.json";

curl --fail --silent --show-error "${DROID_URL}" --output "$ISODATE-android.json";

#!/usr/bin/env bash

get_aggregate() {
    TPLATFORM="$1"
    ISODATE="$2"
    ARTIFACT_BASE="$ISODATE-$TPLATFORM";

    ../generate_aggregate_json_by_date.py "$TPLATFORM" "$ISODATE" "${ARTIFACT_BASE}-side-by-side.mp4" "${ARTIFACT_BASE}-firefox-filmstrip.json" "${ARTIFACT_BASE}-firefox-cold-browsertime-metrics.json" "${ARTIFACT_BASE}-chrome-filmstrip.json" "${ARTIFACT_BASE}-chrome-cold-browsertime-metrics.json"
}

#get_aggregate "android-amazon" "2024-11-15"
get_aggregate "linux-amazon" "2024-11-20"
get_aggregate "win11-amazon" "2024-11-20"

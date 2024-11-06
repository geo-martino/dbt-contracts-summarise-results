#!/bin/bash

run_url_path="$GITHUB_REPOSITORY/actions/runs/$GITHUB_RUN_ID"

# TODO: workaround to get job ID from API. Fix hardcoded name in 'contains' jq filter.
job_url="$GITHUB_API_URL/repos/${run_url_path}/jobs"
job_id="$(curl -s -X GET -f \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    --url "$job_url" | \
  jq -r ".jobs[] | select(.name | contains(\"$GITHUB_JOB\")) | .id")"

if [[ "$GITHUB_EVENT_NAME" =~ "pull_request" ]]; then
  run_url_path="${run_url_path}?pr=$GH_EVENT_NUMBER"
fi

summary_url="$GITHUB_SERVER_URL/${run_url_path}#summary-$job_id"
echo "::notice::View the summary: $summary_url"

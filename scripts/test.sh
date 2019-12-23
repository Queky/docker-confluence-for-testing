#!/usr/bin/env bash

export JIRA_SERVICE_DESK_VERSION=$(curl -s https://marketplace.atlassian.com/rest/2/applications/confluence/versions/latest | jq -r '.version')
echo "$JIRA_SERVICE_DESK_VERSION"
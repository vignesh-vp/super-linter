#!/usr/bin/env bash

function GetGithubPushEventCommitCount() {
  local GITHUB_EVENT_FILE_PATH
  GITHUB_EVENT_FILE_PATH="${1}"
  local GITHUB_PUSH_COMMIT_COUNT

  if ! GITHUB_PUSH_COMMIT_COUNT=$(jq -r '.commits | length' <"${GITHUB_EVENT_FILE_PATH}"); then
    fatal "Failed to initialize GITHUB_PUSH_COMMIT_COUNT for a push event. Output: ${GITHUB_PUSH_COMMIT_COUNT}"
  fi

  if IsUnsignedInteger "${GITHUB_PUSH_COMMIT_COUNT}" && [ -n "${GITHUB_PUSH_COMMIT_COUNT}" ]; then
    echo "${GITHUB_PUSH_COMMIT_COUNT}"
    return 0
  else
    fatal "GITHUB_PUSH_COMMIT_COUNT is not an integer: ${GITHUB_PUSH_COMMIT_COUNT}"
  fi
}

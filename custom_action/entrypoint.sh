#!/bin/bash
set -e

# Looks for the github event path variable. If true, it means the script is runing on workflow resources 
# if not, then the script is runing on our local workstation
if [ -n "$GITHUB_EVENT_PATH" ];
then
    EVENT_PATH=$GITHUB_EVENT_PATH
elif [ -f ./sample_push_event.json ];
then
    EVENT_PATH='./sample_push_event.json'
    LOCAL_TEST=true
else
    echo "No JSON data to process! :("
    exit 1
fi

# Helps debug. Will print the env vars that are set by the OS
env
jq . < $EVENT_PATH

# if keyword is found.
# Will extract the message from the event path
if jq '.commits[].message, .head_commit.message' < $EVENT_PATH | grep -i -q "$*";
then
    # do something
    echo "Found keyword."
# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi

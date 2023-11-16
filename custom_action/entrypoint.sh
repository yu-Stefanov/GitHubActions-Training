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
  # Create a version vars. Will be used to name and tag the release
    VERSION=$(date +%F.%s)

    # We use the version var and printf statements to format a JSON string and store it in var named DATA
    # Will be posted to github api to create the release
    DATA="$(printf '{"tag_name":"v%s",' $VERSION)"
    DATA="${DATA} $(printf '"target_commitish":"master",')"
    DATA="${DATA} $(printf '"name":"v%s",' $VERSION)"
    DATA="${DATA} $(printf '"body":"Automated release based on keyword: %s",' "$*")"
    DATA="${DATA} $(printf '"draft":false, "prerelease":false}')"

    # We use the github repos var to build the URL that well use to post to the API
    # We will also add the github token var so our call to the API can authenticate to our github account
    URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases?access_token=${GITHUB_TOKEN}"

    # if its a local test then we dont want to post to the API
    if [[ "${LOCAL_TEST}" == *"true"* ]];
    then
        echo "## [TESTING] Keyword was found but no release was created."
    else
        # Post to the API
        echo $DATA | http POST $URL | jq .
    fi
# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi

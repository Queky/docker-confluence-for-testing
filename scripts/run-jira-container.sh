#!/usr/bin/env bash
#-e  Exit immediately if a command exits with a non-zero status.
set -e

function usage
{
    local scriptName=$(basename "$0")
    echo "usage: ${scriptName} x.y.z ENV=VALUE ENV2=VALUE"
    echo "   ";
    echo " Set configuration parameters one after another to personalize the docker container";
    echo " example ${scriptName} 8.4.3 DEBUG_PORT=5006 will set the Jira version to 8.4.3 opening the 5006 port for debugging";
    echo " If no parameters are set , .env file parameters will be set ";
    echo "   ";
    echo "  -h | --help                   : This message";
}

# By default we ignore the first argument
args="${@:2}"

case "$1" in
    [0123456789]* )
        JIRA_VERSION=$1
        shift 1;;
    -h | --help )
        usage;
        exit;; # quit and show usage
    * )
        # If none the above then the first argument is an environment variable
        args="${@:1}"
esac

# Set current folder to parent
cd "$(dirname "$0")"/..

if [[ ! -z "${JIRA_VERSION}" ]]
then
    export JIRA_VERSION=${JIRA_VERSION}
fi

for env_variable in ${args}
do
 export ${env_variable}
 echo "set environment variable -> ${env_variable}"
done

echo "Starting Jira version $JIRA_VERSION"
echo "---------------------------------"

docker-compose up jira
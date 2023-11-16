# This sets alpine linux as the base image for our container
FROM alpine

# Install the tools needed
# Alpine uses the APK command to install packages. The arguments list the packages we need to install
# Installing bash - interpreter for our script
# httpie - to interact with the github api
# jq - to work with data in json format
# which command will show where the tools get installed
RUN apk add --no-cache \
        bash           \
        httpie         \
        jq &&          \
        which bash &&  \
        which http &&  \
        which jq

# Copies our script to the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# The command our container will run when its executed
ENTRYPOINT ["entrypoint.sh"]

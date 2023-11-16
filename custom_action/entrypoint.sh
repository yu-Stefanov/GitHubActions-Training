# Shebang line - this tells the OS which interpreter to use to run the script
#!/bin/bash
# Tells Bash to exit the script immediately if an error is encountered
set -e

# if keyword is found
# the "$*" is variable that contains the argument that were passed to the script 
# in this case we are echoing those args to a grep command that will look for the word fixed
# the -i tells grep to ignore case
# the -q tells grep to be quiet so no output gets printed
if echo "$*" | grep -i -q FIXED;
then
    # do something
    echo "Found keyword."
# otherwise
else
    # exit gracefully
    echo "Nothing to process."
fi


# !!! run chmod +x <script name> to make it executable
# run script like <script path> <arg>

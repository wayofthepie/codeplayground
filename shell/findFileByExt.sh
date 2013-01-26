#!/bin/bash

# $1 - the root of the search path
# $2 - the file extension
# $3 - extra options to find (e.g. adding "-delete" will delete any files found
find $1 -type f -regextype posix-extended -iregex '.*\.('$2')$' $3

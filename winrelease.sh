#! /bin/bash

# As you can't invoke gzip using the IO package in GAP under Windows, we can't
# ship the gzipped data of the external libraries of unitals to Windows. So
# upon release you should run this script:
#
#   ./winrelease.sh
#

function usage {
    echo -e "usage:\t\t\t`basename $0` version-number"
    exit 1
}

# Checking the number of parameters.
if [ $# -ne 1 ]; then
    echo -e "`basename $0`:\t\tNot enough/too many parameters."
    echo ""
    usage
fi

# Creating the documentation
gap makedoc.g
# Unzipping the data
gunzip data/*.gz
# Creating the Windows release of UnitalSZ
zip -r UnitalSZ-$1-win.zip ./* -x winrelease.sh
# Gzipping the data
gzip data/*.txt
# Revert unzipping to HEAD
git checkout HEAD data/*

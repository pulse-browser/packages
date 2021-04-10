#!/bin/bash

# Create a working environment for packaging Dot Browser

showHelp () {
    echo "createDeb.sh, version 1.0.0"
    echo "Usage:  createDeb.sh [option]"
    echo "Options:"
    echo "  -h             Show this help message"
    echo "  -f             .tar.bz2 file to create .deb for"
    echo "  -v             Dot Browser Version"
    echo "  -a             Architecture to create .deb for"
}

while getopts :hf:v:a: option
do
    case "${option}" in
        h) showHelp ;;
        f) echo "file ${OPTARG}" ;;
        v) echo "version ${OPTARG}" ;;
        a) echo "arch ${OPTARG}" ;;
        *) echo "Invalid option: -${OPTARG}" ;;
    esac
done

# If no parameters, show help message
if [ -z $1 ]; then
    showHelp
fi
#!/bin/bash

set -eu

############################################################
# Some defaults
############################################################
arch=linux/arm64
version=5.7.2
product=SwiftLambdaAPI

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Run within a Swift server side project to build with docker."
   echo
   echo "Syntax: ./build.sh [-v|a|h]"
   echo "options:"
   echo "a     Sets the CPU architecture to build. Default linux/arm64 or linux/amd64."
   echo "h     Print this Help."
   echo "v     Sets the Swift version to use. Default 5.7.2."
   echo
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################
############################################################
# Process the input options. Add options as needed.        #
############################################################
# Get the options
while getopts ":v:a:h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      a) # set arch
          arch=${OPTARG:-linux/arm64};;
      v) # set version
          version=${OPTARG:-5.7.2};;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done

docker run --rm -v "${PWD}:/code" -w /code --platform ${arch} swift:${version}-amazonlinux2 swift build --product ${product} -c release -Xswiftc -static-stdlib

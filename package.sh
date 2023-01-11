#!/bin/bash

set -eu

############################################################
# Some defaults
############################################################
executable=SwiftLambdaAPI

############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Run within a Swift server side project to package an already built project as a zip for upload."
   echo
   echo "Syntax: ./package.sh [-n|h]"
   echo "options:"
   echo "n     Sets the name of the project to package."
   echo "h     Print this Help."
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
while getopts ":n:h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
      n) # set name
          executable=${OPTARG};;
     \?) # Invalid option
         echo "Error: Invalid option"
         exit;;
   esac
done


target=.build/lambda/${executable}
rm -rf "$target"
mkdir -p "$target"
cp ".build/release/$executable" "$target/"
cd "$target"
ln -s "$executable" "bootstrap"
zip --symlinks lambda.zip *

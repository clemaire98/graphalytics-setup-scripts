#!/bin/sh

# Get the path of this script.
_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

# Run the install-arguments script.
eval $($_SCRIPT_PATH/parse-args.sh "$@")
export _INST_CLEAN
export _INST_HOME

# Set the graphalytics-core home directory
GL_CORE_HOME=$_INST_HOME/ldbc-graphalytics

# Clone the graphalytics core repo
if [ "$_INST_CLEAN" = "1" ]
then
	# Remove old copy of graphalytics-core.
	rm -rf $GL_CORE_HOME
	
	git clone https://github.com/ldbc/ldbc_graphalytics.git $GL_CORE_HOME
fi


# Install all underlying repos with the same options
$_SCRIPT_PATH/openg/install.sh --main

#!/bin/sh

# Declare openg install directory.
_OPENG_INSTALL_DIR=openg-3.2

# Get the path of this script.
_SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

# Run the install-arguments script.
if [ "$1" != "--main" ]
then
	eval $($_SCRIPT_PATH/../install-arguments.sh "$@")
fi

# Name of the config directory of graphalytics
CONF_DIR=conf

# Path variables for paths of confs and openg_home
OPENG_HOME=$_INST_HOME/$_OPENG_INSTALL_DIR/graphBIG
GRAPH_PLAT_HOME=$_INST_HOME/$_OPENG_INSTALL_DIR/graphalytics-platforms-openg
OPENG_CONF=$_INST_HOME/$_OPENG_INSTALL_DIR/graphalytics-platforms-openg/$CONF_DIR/openg.properties

if [ "$_INST_CLEAN" = "1" ]
then
	# Delete the current packages to be sure of a clean install
	echo Removing $GRAPH_PLAT_HOME
	rm -rf $GRAPH_PLAT_HOME

	echo Removing $OPENG_HOME
	rm -rf $OPENG_HOME

	# Clone the necessary repositories and dependencies
	git clone https://github.com/atlarge-research/graphalytics-platforms-openg $GRAPH_PLAT_HOME
	git clone https://github.com/graphbig/graphBIG.git $OPENG_HOME

	# Rename config-template folder to config
	mv $GRAPH_PLAT_HOME/config-template $GRAPH_PLAT_HOME/$CONF_DIR
fi

# Edit the config file of graphalytics to point to the
# openg directory.
echo Configuring $OPENG_CONF to have \'openg.home = $OPENG_HOME\'
$_SCRIPT_PATH/../util/configure.sh "openg\.home" $OPENG_HOME $OPENG_CONF

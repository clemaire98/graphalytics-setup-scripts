#!/bin/sh

# Declare openg install directory.
OPENG_INSTALL_DIR=openg-3.2

# Declare the name of the config directory of graphalytics
CONF_DIR=conf

# Declare openg intermediate directory.
OPENG_INT=tmp/openg

# Get the path of this script.
SCRIPT_PATH=$(dirname "$(readlink -f "$0")")



# Run the parse-args script.
if [ "$1" != "--main" ]
then
	eval $($SCRIPT_PATH/../parse-args.sh "$@")
fi


# Path variables for paths of confs and openg_home
OPENG_HOME=$_INST_HOME/$OPENG_INSTALL_DIR/graphBIG
GRAPH_PLAT_HOME=$_INST_HOME/$OPENG_INSTALL_DIR/graphalytics-platforms-openg
OPENG_CONF=$_INST_HOME/$OPENG_INSTALL_DIR/graphalytics-platforms-openg/$CONF_DIR/openg.properties



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



# Edit the config file of the graphalytics platform driver.
echo Configuring \'$OPENG_CONF\'.
$SCRIPT_PATH/../util/configure.sh "openg.home" $OPENG_HOME $OPENG_CONF
$SCRIPT_PATH/../util/configure.sh "openg.intermediate-dir" $_INST_HOME/$OPENG_INT $OPENG_CONF

# Make the intermediate directory to be sure.
mkdir -p $_INST_HOME/$OPENG_INT



# Copy build file over to the installation home directory.
echo Placing \'build.sh\' file in \'$_INST_HOME/$OPENG_INSTALL_DIR/\'
cp $SCRIPT_PATH/build.sh $_INST_HOME/$OPENG_INSTALL_DIR/build.sh
chmod +x $_INST_HOME/$OPENG_INSTALL_DIR/build.sh

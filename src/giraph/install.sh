#!/bin/sh

# Declare giraph install directory.
INSTALL_DIR=giraph-1.2.0

# Declare the name of the config directory of graphalytics
CONF_DIR=config-template

# Declare giraph intermediate directory.
#giraph_INT=tmp/giraph

# Get the path of this script.
SCRIPT_PATH=$(dirname "$(readlink -f "$0")")



# Run the parse-args script.
if [ "$1" != "--main" ]
then
	eval $($SCRIPT_PATH/../parse-args.sh "$@")
fi


# Path variables for paths of confs and GIRAPH_HOME
GIRAPH_HOME=$_INST_HOME/$INSTALL_DIR/giraph
GRAPH_PLAT_HOME=$_INST_HOME/$INSTALL_DIR/graphalytics-platforms-giraph
GIRAPH_CONF=$_INST_HOME/$INSTALL_DIR/graphalytics-platforms-giraph/$CONF_DIR/giraph.properties



if [ "$_INST_CLEAN" = "1" ]
then
	# Delete the current packages to be sure of a clean install
	echo Removing $GRAPH_PLAT_HOME
	rm -rf $GRAPH_PLAT_HOME

	echo Removing $GIRAPH_HOME
	rm -rf $GIRAPH_HOME

	# Clone the necessary repositories and dependencies
	git clone https://github.com/atlarge-research/graphalytics-platforms-giraph.git $GRAPH_PLAT_HOME
	
    # Get Giraph and unpack it
    wget http://apache.xl-mirror.nl/giraph/giraph-1.2.0/giraph-dist-1.2.0-bin.tar.gz -P $GIRAPH_HOME
    tar -xvzf $GIRAPH_HOME/giraph-dist-1.2.0-bin.tar.gz
    rm -f $GIRAPH_HOME/giraph-dist-1.2.0-bin.tar.gz

	# Rename config-template folder to config
	#mv $GRAPH_PLAT_HOME/config-template $GRAPH_PLAT_HOME/$CONF_DIR
fi



# Edit the config file of the graphalytics platform driver.
echo Configuring \'$GIRAPH_CONF\'.
$SCRIPT_PATH/../util/configure.sh "giraph.home" $GIRAPH_HOME $GIRAPH_CONF



# Copy build file over to the installation home directory.
echo Placing \'build.sh\' file in \'$_INST_HOME/$INSTALL_DIR/\'
cp $SCRIPT_PATH/build.sh $_INST_HOME/$INSTALL_DIR/build.sh
chmod +x $_INST_HOME/$INSTALL_DIR/build.sh

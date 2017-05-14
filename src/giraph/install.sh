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


# Path variables for paths of confs and GIRAPH_HOME and HADOOP_HOME
GIRAPH_HOME=$_INST_HOME/$INSTALL_DIR/giraph
HADOOP_HOME=$_INST_HOME/$INSTALL_DIR/hadoop
GRAPH_PLAT_HOME=$_INST_HOME/$INSTALL_DIR/graphalytics-platforms-giraph
GIRAPH_CONF=$_INST_HOME/$INSTALL_DIR/graphalytics-platforms-giraph/$CONF_DIR/giraph.properties



if [ "$_INST_CLEAN" = "1" ]
then
	# Delete the current packages to be sure of a clean install
	echo Removing $GRAPH_PLAT_HOME
	rm -rf $GRAPH_PLAT_HOME

	echo Removing $GIRAPH_HOME
	rm -rf $GIRAPH_HOME

	echo Removing $HADOOP_HOME
	rm -rf $HADOOP_HOME

	# Clone the necessary repositories and dependencies
	git clone https://github.com/atlarge-research/graphalytics-platforms-giraph.git $GRAPH_PLAT_HOME
	
    # Get Giraph and unpack it
    wget http://apache.xl-mirror.nl/giraph/giraph-1.2.0/giraph-dist-1.2.0-bin.tar.gz -P $_INST_HOME
    tar -xzf $_INST_HOME/giraph-dist-1.2.0-bin.tar.gz -C $_INST_HOME
    rm -f $_INST_HOME/giraph-dist-1.2.0-bin.tar.gz
    find $_INST_HOME -maxdepth 1 -name "giraph-*-for-hadoop-*" | xargs -I '{}' mv '{}' $GIRAPH_HOME

    # Get Hadoop and unpack it
    wget http://archive.apache.org/dist/hadoop/core/hadoop-0.20.203.0/hadoop-0.20.203.0rc1.tar.gz -P $_INST_HOME
    tar -xzf hadoop-0.20.203.0rc1.tar.gz -C $_INST_HOME
  #  rm -f $_INST_HOME/hadoop-0.20.203.0rc1.tar.gz
  #  find $_INST_HOME -maxdepth 1 -name "hadoop-*" | xargs -I '{}' mv '{}' $HADOOP_HOME

fi



# Edit the config file of the graphalytics platform driver.
echo Configuring \'$GIRAPH_CONF\'.
$SCRIPT_PATH/../util/configure.sh "giraph.home" $GIRAPH_HOME $GIRAPH_CONF



# Copy build file over to the installation home directory.
echo Placing \'build.sh\' file in \'$_INST_HOME/$INSTALL_DIR/\'
cp $SCRIPT_PATH/build.sh $_INST_HOME/$INSTALL_DIR/build.sh
chmod +x $_INST_HOME/$INSTALL_DIR/build.sh

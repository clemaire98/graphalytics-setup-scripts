# Run the install-arguments script.
../install-arguments.sh parse "$@"

# Name of the config directory of graphalytics
CONF_DIR=conf

# Path variables for paths of confs and openg_home
OPENG_HOME=$_INST_HOME/graphBIG
GRAPH_PLAT_HOME=$_INST_HOME/graphalytics-platforms-openg
OPENG_CONF=$_INST_HOME/graphalytics-platforms-openg/$CONF_DIR/openg.properties

if [ "$_INST_CLEAN" = "1" ]
then
	# Delete the current packages to be sure of a clean install
	echo Removing $GRAPH_PLAT_HOME
	rm -rf $GRAPH_PLAT_HOME

	echo Removing $OPENG_HOME
	rm -rf $OPENG_HOME

	# Clone the necessary repositories and dependencies
	git clone https://github.com/atlarge-research/graphalytics-platforms-openg
	git clone https://github.com/graphbig/graphBIG.git

	# Rename config-template folder to config
	mv $GRAPH_PLAT_HOME/config-template $GRAPH_PLAT_HOME/$CONF_DIR
fi

# Edit the config file of graphalytics to point to the
# openg directory.
echo Configuring $OPENG_CONF to have \'openg.home = $OPENG_HOME\'
sed -i "s+\(\s*openg\.home\s*=\s*\)+\1$OPENG_HOME+" $OPENG_CONF

# Run the install-arguments script for cleaning up.
../install-arguments.sh clean "$@"

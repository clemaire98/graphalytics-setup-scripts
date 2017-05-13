# Name of the config directory of graphalytics
CONF_DIR=conf

# Path variables for paths of confs and openg_home
OPENG_HOME=$PWD/graphBIG/
OPENG_CONF=$PWD/graphalytics-platforms-openg/$CONF_DIR/openg.properties

if [ "$1" == "-c" ]
then
	# Delete the current packages to be sure of a clean install
	echo Removing ./graphalytics-platforms-openg/
	rm -rf ./graphalytics-platforms-openg/

	echo Removing ./graphBIG/
	rm -rf ./graphBIG/

	# Clone the necessary repositories and dependencies
	git clone https://github.com/atlarge-research/graphalytics-platforms-openg
	git clone https://github.com/graphbig/graphBIG.git

	# Rename config-template folder to config
	mv ./graphalytics-platforms-openg/config-template ./graphalytics-platforms-openg/$CONF_DIR
fi

# Edit the config file of graphalytics to point to the
# openg directory.
echo Configuring $OPENG_CONF to have \'openg.home = $OPENG_HOME\'
sed -i "s+\(\s*openg\.home\s*=\s*\)+\1$OPENG_HOME+" $OPENG_CONF


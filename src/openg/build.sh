# Declare variables regarding install.
CORE_DIR=ldbc-graphalytics
PLUGIN_DIR=graphalytics-platforms-openg


# Get the path of this script.
# This is presumed to be in the home directory for a certain
# platform (openg in this case).
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
CORE_ABS_DIR=$SCRIPT_DIR/../$CORE_DIR
PLUGIN_ABS_DIR=$SCRIPT_DIR/$PLUGIN_DIR

# Run mvn install once in the core repository to install the
# Graphalytics core to a local Maven repository.
if [ ! -d "$CORE_ABS_DIR/graphalytics-core/target" ]
then
	echo Building graphalytics core repo.
	mvn -f $CORE_ABS_DIR/pom.xml -q clean install
else
	echo Graphalytics core repo has been built already. \[Skipped\]
fi

# Run mvn package in the platform repository to create a binary
# of the platform extension and a distributable archive ("Graphalytics distribution").
echo Packaging graphalytics platform plugin.
mvn -f $PLUGIN_ABS_DIR/pom.xml -q clean package


# Move the packaged repo to the home directory and unpack it.
echo Moving bin.tar.gz into openg-home directory.
mv $PLUGIN_ABS_DIR/graphalytics-*-openg-*-bin.tar.gz $SCRIPT_DIR/

echo Unpacking bin.tar.gz.
find $SCRIPT_DIR/ -name "graphalytics-*-openg-*-bin.tar.gz" | xargs tar -xzf

echo Removing remaining tar.gz.
find $SCRIPT_DIR/ -name "graphalytics-*-openg-*-bin.tar.gz" | xargs rm

# Declare variables regarding install.
CORE_DIR=ldbc-graphalytics
PLUGIN_DIR=graphalytics-platforms-openg


# Get the path of this script.
# This is presumed to be in the home directory for a certain
# platform (openg in this case).
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
echo Script directory is \'$SCRIPT_DIR\'.
CORE_ABS_DIR=$SCRIPT_DIR/../$CORE_DIR
PLUGIN_ABS_DIR=$SCRIPT_DIR/$PLUGIN_DIR

# Run mvn install once in the core repository to install the
# Graphalytics core to a local Maven repository.
if [ ! -d "$CORE_ABS_DIR/graphalytics-core/target" ]
then
	echo Building graphalytics core repo.
	mvn -f $CORE_ABS_DIR/pom.xml -q clean install -DoutputDirectory=$SCRIPT_DIR/
else
	echo Graphalytics core repo has been built already. \[Skipped\]
fi

# First attempt to remove any packaged repos.
find $SCRIPT_DIR/ -maxdepth 1 -name "graphalytics-*-openg-*" | xargs rm -rf
 
# Run mvn package in the platform repository to create a binary
# of the platform extension and a distributable archive ("Graphalytics distribution").
echo Packaging graphalytics platform plugin.
mvn -f $PLUGIN_ABS_DIR/pom.xml -q clean package -DoutputDirectory=$SCRIPT_DIR/


# Move the packaged repo to the home directory and unpack it.
echo Unpacking bin.tar.gz.
find $SCRIPT_DIR/ -name "graphalytics-*-openg-*-bin.tar.gz" | xargs tar -C $SCRIPT_DIR/ -xzf

echo Removing remaining tar.gz.
find $SCRIPT_DIR/ -name "graphalytics-*-openg-*-bin.tar.gz" | xargs rm

COMPILED_DIR=$(find $SCRIPT_DIR/ -maxdepth 1 -name "graphalytics-*-openg-*" | xargs readlink -f)

# Rename config directory.
echo Renaming config directory to \'config\'
mv --force $COMPILED_DIR/config-template/ $COMPILED_DIR/config/

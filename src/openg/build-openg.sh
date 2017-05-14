# Declare variables regarding install.
CORE_DIR=ldbc-graphalytics


# Get the path of this script.
# This is presumed to be in the home directory for a certain
# platform (openg in this case).
SCRIPT_PATH=$(dirname "$(readlink -f "$0")")

# Run mvn install once in the core repository to install the
# Graphalytics core to a local Maven repository.
mvn -f $SCRIPT_PATH/../$CORE_DIR/pom.xml clean install

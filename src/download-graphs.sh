#!/bin/bash

DEFAULT_DIR=/var/scratch/clemaire/graphs

# As a parameter we get the directory to download these into, or we default to a directory.
if [[ $* == *-d* ]]; then
	echo Starting with default directory.
	GRAPH_DIR=$DEFAULT_DIR
elif [ -d "$1" ]; then
	echo Starting with \'$1\' as directory.
	GRAPH_DIR="$1"
else
	echo Invalid graph-directory: \'$1\'.
	echo Start with -d to use the default directory \'$DEFAULT_DIR\'
	exit
fi

# Make the graph directory if it doesn't exist yet.
if [ ! -d $GRAPH_DIR ]; then
	mkdir -p $GRAPH_DIR
fi

# Download graphs into the graphs directory.
if [[ (! -d "$GRAPH_DIR/dota-league" && $* == *dl*) || $* == *-a* ]]; then
	echo Downloading dota-league...
	wget https://atlarge.ewi.tudelft.nl/graphalytics/zip/dota-league.zip -P $GRAPH_DIR/
	unzip $GRAPH_DIR/dota-league.zip -d $GRAPH_DIR
	rm -rf $GRAPH_DIR/dota-league.zip
fi
if [[ (! -d "$GRAPH_DIR/kgs" && $* == *kgs*) || $* == *-a* ]]; then
	echo Downloading kgs...
	wget https://atlarge.ewi.tudelft.nl/graphalytics/zip/kgs.zip -P $GRAPH_DIR/
	unzip $GRAPH_DIR/kgs.zip -d $GRAPH_DIR
	rm -rf $GRAPH_DIR/kgs.zip
fi
if [[ (! -d "$GRAPH_DIR/example-directed" && $* == *exdir*) || $* == *-a* ]]; then
	echo Downloading example-directed...
	wget https://atlarge.ewi.tudelft.nl/graphalytics/zip/example-directed.zip -P $GRAPH_DIR/
	unzip $GRAPH_DIR/example-directed.zip -d $GRAPH_DIR
	rm -rf $GRAPH_DIR/example-directed.zip
fi
if [[ (! -d "$GRAPH_DIR/example-undirected" && $* == *exundir*) || $* == *-a* ]]; then
	echo Downloading example-undirected...
	wget https://atlarge.ewi.tudelft.nl/graphalytics/zip/example-undirected.zip -P $GRAPH_DIR/
	unzip $GRAPH_DIR/example-undirected.zip -d $GRAPH_DIR
	rm -rf $GRAPH_DIR/example-undirected.zip
fi



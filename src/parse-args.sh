#!/bin/bash

# Export the unpack directory, which should be the first parameter.
_INST_HOME=$HOME/graphalytics-0.3

while [ $# -gt 0 ]
do
	case "$1" in
		-p|--path)
			shift
			
			if [ $# -lt 1 ]
			then
				echo Expected home path after -p|--path.
				exit
			else
				_INST_HOME="$1"
			fi
			;;
		-c|--clean)
			_INST_CLEAN=1
			;;
	esac
	shift
done

echo "_INST_HOME="$_INST_HOME"; _INST_CLEAN="$_INST_CLEAN""

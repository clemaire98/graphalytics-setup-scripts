# If this script has already been run in the same mode, exit.
_RUN_MODE="$1"
shift

if [ "$_RUN_MODE" = "parse" ]
then
	# Export the unpack directory, which should be the first parameter.
	_INST_HOME=$HOME

	while [ $# -gt 1 ]
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
				export _INST_CLEAN
				;;
		esac
		shift
	done

	export _INST_HOME
elif [ "$_RUN_MODE" = "clean" ]
then
	# Clean up temporary variables
	unset _INST_CLEAN
	unset _INST_HOME
else
	echo Invalid run mode $_RUN_MODE.
	echo Possible run modes are: \'parse\' and \'clean\'.
fi

# Export the unpack directory, which should be the first parameter.
_INST_HOME=$HOME

while [ $# -gt 1 ]
do
	case "$1" in
		-p|--path)
			shift
			
			if [ $# -lt 1 ]
			then
				echo Expected start path after -p|--path.
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

# Clone the graphalytics core repo
git clone https://github.com/ldbc/ldbc_graphalytics.git


# Install all underlying repos with the same options
openg/install.sh "$@"


# Clean up temporary variables
unset _INST_CLEAN
unset _INST_HOME

# Run the install-arguments script.
./install-arguments.sh parse "$@"

# Clone the graphalytics core repo
if [ "$_INST_CLEAN" = "1" ]
then
	git clone https://github.com/ldbc/ldbc_graphalytics.git $HOME/ldcs-graphalytics
fi


# Install all underlying repos with the same options
./openg/install-openg.sh

# Run the install-arguments script for cleaning up.
../install-arguments.sh clean "$@"

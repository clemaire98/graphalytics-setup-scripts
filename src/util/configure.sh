# Save the configuration parameters.
config_name=$1
config_value=$2
config_path=$3

# Configure
echo Setting \'$config_name\' configuration to \'$config_value\'.
sed -i "s+\(\s*$config_name\s*=\s*\).*+\1$config_value+" $config_path

config_name=$1
config_value=$2
config_path=$3

echo Configuring \'$config_name\' configuration in \'$config_path\' to $config_value.
sed -i "s+\(\s*$config_name\s*=\s*\).*+\1$config_value+" $config_path

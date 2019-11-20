#! /bin/bash

set -e

scripthome=$(realpath $(dirname $0))

# Make a link to zsh modules so that they're in a predictable place.
echo "Linking modules directory $scripthome/modules -> $HOME/.zsh_modules"
ln -sf $scripthome/modules $HOME/.zsh_modules

for config in $scripthome/config/*; do
    configtarget="$HOME/.$(basename $config)"

    # Check the original.
    if [ -f $configtarget ]; then 
	if [ ! -h $configtarget ]; then
	    echo "Moving original file $configtarget -> $configtarget.bak"
            mv $configtarget "$configtarget.bak"
	fi
    fi
    
    # Make links
    echo "Linking $configtarget -> $config"
    ln -fs $config $configtarget 
done

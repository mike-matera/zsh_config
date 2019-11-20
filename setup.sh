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

# Install fonts
echo "Installing fonts."
(
    if [ ! -d $HOME/.local/share/fonts ]; then 
	mkdir -p $HOME/.local/share/fonts
    fi
    cd $HOME/.local/share/fonts 
    wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Bold%20Italic.ttf
)
fc-cache -fv

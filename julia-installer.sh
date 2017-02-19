#!/bin/bash

## Verify before overwriting
if [ -d "$HOME/.julia/" ]; then
    read -p "Directory already exists. Continue with reinstall? (y/N) " -n 1 -r
    echo    
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
fi

## Download and unpack tarball
curl -sS https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.0-linux-x86_64.tar.gz -o julia-0.5.0.tar.gz
tar -xf julia-0.5.0.tar.gz

rm -rf $HOME/.julia/
mv julia-3c9d75391c/ ~/.julia/
rm -f julia-0.5.0.tar.gz

## Export path variables
export PATH="$HOME/.julia/bin:$PATH"
printf '\n# added by julia install script\nexport PATH="$HOME/.julia/bin:$PATH"' >> ~/.profile

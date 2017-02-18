if [ -d "$HOME/.julia/" ]; then
    read -p "Directory already exists. Continue? (y/N) " -n 1 -r
    echo    
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
fi
curl -sS https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.0-linux-x86_64.tar.gz -o julia-0.5.0.tar.gz
tar -xvf julia-0.5.0.tar.gz
rm -rf $HOME/.julia/
mv julia-3c9d75391c/ ~/.julia/
rm -f julia-0.5.0.tar.gz

#!/bin/zsh 


pip install ipykernel
python -m ipykernel install --user --name=$(basename $PWD)

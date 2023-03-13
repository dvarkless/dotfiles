#!/bin/zsh

cp ~/.config/nvim/lua/custom . -r
rm -rf ./custom/.git/
cp ~/.zshrc zshrc
cp ~/.bashrc bashrc
cp ~/.p10k.zsh p10k.zsh

source $JUPYTER_VENV
pip freeze >> requirements_jupyter_venv.txt
deactivate

source $TENSORFLOW_VENV
pip freeze >> requirements_tensorflow_venv.txt
deactivate

source ~/.venvs/nvim_venv/bin/activate
pip freeze >> requirements_nvim_venv.txt
deactivate

pip freeze >> requirements_system.txt

pamac list >> system_packages.txt

DATE=$(date +"%x")

git add *
git commit -m "Update files at $DATE"
git push -u

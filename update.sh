#!/bin/zsh
cd /run/media/dvarkless/LinuxData/Files/dotfiles

cp ~/.config/nvim/lua/custom . -r
cp ~/shell_commands . -r
rm -rf ./custom/.git/
cp ~/.zshrc zshrc
cp ~/.bashrc bashrc
cp ~/.p10k.zsh p10k.zsh

JUPYTER_STR=$(cat ~/.zshrc | grep JUPYTER_VENV)
echo $JUPYTER_STR
JUPYTER_VENV=${JUPYTER_STR#*'='}
echo $JUPYTER_VENV
source $JUPYTER_VENV
pip freeze >> requirements_jupyter_venv.txt
deactivate

TENSORFLOW_STR=$(cat ~/.zshrc | grep TENSORFLOW_VENV)
TENSORFLOW_VENV=${TENSORFLOW_STR#*'='}
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

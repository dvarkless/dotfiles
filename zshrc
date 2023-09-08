# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export TENSORFLOW_VENV=/run/media/dvarkless/LinuxData/venvs/tensorflow_venv/bin/activate
export JUPYTER_VENV=/run/media/dvarkless/LinuxData/venvs/jupyter_venv/bin/activate
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export NEOVIM_VENV=/home/dvarkless/.venvs/nvim_venv/bin/activate
alias kill_jupyter_port='fuser -k 8888/tcp'
alias :q=exit
export NUMBA_COLOR_SCHEME=dark_bg
export EDITOR='/usr/bin/nvim'

alias upload_backup='rclone sync /run/media/dvarkless/LinuxData/Cloud/ cloud_drive15G:files_backup'
alias download_backup='rclone sync cloud_drive15G:files_backup /run/media/dvarkless/LinuxData/Cloud/'

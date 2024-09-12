
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if [ -f '/c/Users/Usuario/anaconda3/Scripts/conda.exe' ]; then
    eval "$('/c/Users/Usuario/anaconda3/Scripts/conda.exe' 'shell.bash' 'hook')"
fi
# <<< conda initialize <<<

# Alias para suplir el problema con el shell de poetry
alias poetryshell="source ./.venv/Scripts/activate"
alias master-node="ssh sertemo@trymlmodels.com -p 2222"
alias worker-node1-wifi="ssh sertemo@192.168.1.36"
alias worker-node2-wifi="ssh sertemo@192.168.1.38"


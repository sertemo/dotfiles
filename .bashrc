env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env

#### ####
function set_virtualenv {
    if [[ -n "$VIRTUAL_ENV" ]]
    then
        # Asegúrate de que el archivo pyproject.toml existe en el directorio actual
        if [[ -f "pyproject.toml" ]]; then
            # Extraer el nombre del entorno virtual de pyproject.toml
            ENV_NAME=$(grep 'name =' pyproject.toml | awk '{print $3}' | tr -d '"')
        fi
        
        # Si ENV_NAME no está vacío, y PS1 no contiene ya el nombre del entorno
        if [[ -n "$ENV_NAME" && "$PS1" != *"$ENV_NAME"* ]]; then
            PS1="($ENV_NAME) $PS1"
        fi
    fi
}

PROMPT_COMMAND=set_virtualenv
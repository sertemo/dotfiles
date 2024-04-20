# Inicia ssh-agent. Agregado para GitHub que al iniciar Windows powershell ejecute este script
Start-Service ssh-agent

# Agrega tu clave SSH
ssh-add ~\.ssh\id_ed25519
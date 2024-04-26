
if [[ ":$PATH:" != *"$HOME/bin"* ]]; then
  export PATH="$HOME/bin:$PATH"
fi  

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

source ~/.zshrc

eval "$(ssh-agent -s)" > /dev/null 2>&1
ssh-add ~/.ssh/github > /dev/null 2>&1 
ssh-add ~/.ssh/azure_repo > /dev/null 2>&1


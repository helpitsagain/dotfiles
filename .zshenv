
if [[ ":$PATH:" != *"$HOME/bin"* ]]; then
  export PATH="$HOME/bin:$PATH"
fi  

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

source ~/.zshrc

